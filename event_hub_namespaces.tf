
module "event_hub_namespaces" {
  source   = "./modules/event_hub_namespaces"
  for_each = var.event_hub_namespaces

  global_settings = local.global_settings
  settings        = each.value
  resource_groups = module.resource_groups
  client_config   = local.client_config
  base_tags       = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

module event_hub_namespaces_diagnostics {
  source   = "./modules/diagnostics"
  for_each = var.event_hub_namespaces

  resource_id       = module.event_hub_namespaces[each.key].id
  resource_location = module.event_hub_namespaces[each.key].location
  diagnostics       = local.diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}

#
# Event_hub_namespace is one of the three diagnostics destination objects and for that reason requires the 
# private endpoint to be done at the root module to prevent circular references
#

module event_hub_namespaces_private_endpoints {
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
            location            = module.resource_groups[pe.resource_group_key].location
            resource_group_name = module.resource_groups[pe.resource_group_key].name
            subnet_id           = try(pe.vnet_key, null) == null ? null : try(local.combined_objects_networking[local.client_config.landingzone_key][pe.vnet_key].subnets[pe.subnet_key].id, local.combined_objects_networking[pe.lz_key][pe.vnet_key].subnets[pe.subnet_key].id)
            base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[pe.resource_group_key].tags : {}
          }
        ]
      ]
    ) : format("%s-%s", private_endpoint.eh_ns_key, private_endpoint.pe_key) => private_endpoint
  }
}
