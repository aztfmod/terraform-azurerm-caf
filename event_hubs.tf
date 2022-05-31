
module "event_hub_namespaces" {
  source   = "./modules/event_hubs/namespaces"
  for_each = var.event_hub_namespaces

  global_settings  = local.global_settings
  settings         = each.value
  storage_accounts = local.combined_objects_storage_accounts
  client_config    = local.client_config
  base_tags        = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
  resource_group   = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
}

output "event_hub_namespaces" {
  value = module.event_hub_namespaces
}

module "event_hub_namespace_auth_rules" {
  source   = "./modules/event_hubs/namespaces/auth_rules"
  for_each = try(var.event_hub_namespace_auth_rules, {})

  client_config   = local.client_config
  global_settings = local.global_settings
  namespace_name  = module.event_hub_namespaces[each.value.event_hub_namespace_key].name
  settings        = each.value
  resource_group  = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]


  depends_on = [
    module.event_hub_namespaces
  ]
}

output "event_hub_namespace_auth_rules" {
  value = module.event_hub_namespace_auth_rules
}

module "event_hub_namespaces_diagnostics" {
  source   = "./modules/diagnostics"
  for_each = var.event_hub_namespaces

  resource_id       = module.event_hub_namespaces[each.key].id
  resource_location = module.event_hub_namespaces[each.key].location
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}

#
# Event_hub_namespace is one of the three diagnostics destination objects and for that reason requires the
# private endpoint to be done at the root module to prevent circular references
#

module "event_hub_namespaces_private_endpoints" {
  depends_on = [module.event_hub_namespaces]
  source     = "./modules/networking/private_endpoint"
  for_each   = local.event_hub_namespaces_private_endpoints

  resource_id         = each.value.id
  name                = each.value.settings.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = each.value.subnet_id
  settings            = each.value.settings
  global_settings     = local.global_settings
  base_tags           = each.value.base_tags
  private_dns         = local.combined_objects_private_dns
  client_config       = local.client_config
}

locals {
  event_hub_namespaces_private_endpoints = {
    for private_endpoint in
    flatten(
      [
        for eh_ns_key, eh_ns in var.event_hub_namespaces : [
          for pe_key, pe in try(eh_ns.private_endpoints, {}) : {
            eh_ns_key           = eh_ns_key
            pe_key              = pe_key
            id                  = module.event_hub_namespaces[eh_ns_key].id
            settings            = pe
            location            = local.resource_groups[pe.resource_group_key].location
            resource_group_name = local.resource_groups[pe.resource_group_key].name
            subnet_id           = try(pe.vnet_key, null) == null ? null : try(local.combined_objects_networking[local.client_config.landingzone_key][pe.vnet_key].subnets[pe.subnet_key].id, local.combined_objects_networking[pe.lz_key][pe.vnet_key].subnets[pe.subnet_key].id)
            base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[pe.resource_group_key].tags : {}
          }
        ]
      ]
    ) : format("%s-%s", private_endpoint.eh_ns_key, private_endpoint.pe_key) => private_endpoint
  }
}


module "event_hubs" {
  source     = "./modules/event_hubs/hubs"
  depends_on = [module.event_hub_namespaces]
  for_each   = try(var.event_hubs, {})

  client_config      = local.client_config
  global_settings    = local.global_settings
  settings           = each.value
  namespace_name     = module.event_hub_namespaces[each.value.event_hub_namespace_key].name
  storage_account_id = try(module.storage_accounts[each.value.storage_account_key].id, null)
  base_tags          = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  resource_group     = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]

}

module "event_hub_auth_rules" {
  source   = "./modules/event_hubs/hubs/auth_rules"
  for_each = try(var.event_hub_auth_rules, {})

  client_config   = local.client_config
  global_settings = local.global_settings
  settings        = each.value
  namespace_name  = module.event_hub_namespaces[each.value.event_hub_namespace_key].name
  eventhub_name   = module.event_hubs[each.value.event_hub_name_key].name
  resource_group  = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]


  depends_on = [
    module.event_hub_namespaces,
    module.event_hubs
  ]
}

output "event_hub_auth_rules" {
  value = module.event_hub_auth_rules
}

module "event_hub_consumer_groups" {
  source   = "./modules/event_hubs/consumer_groups"
  for_each = try(var.event_hub_consumer_groups, {})

  client_config   = local.client_config
  global_settings = local.global_settings
  settings        = each.value
  namespace_name  = module.event_hub_namespaces[each.value.event_hub_namespace_key].name
  eventhub_name   = module.event_hubs[each.value.event_hub_name_key].name
  resource_group  = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]


  depends_on = [
    module.event_hub_namespaces,
    module.event_hubs
  ]
}
