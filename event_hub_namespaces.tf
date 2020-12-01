
module "event_hub_namespaces" {
  source   = "./modules/event_hub_namespaces"
  for_each = var.event_hub_namespaces

  global_settings   = local.global_settings
  settings          = each.value
  resource_groups   = module.resource_groups
  # vnets             = try(local.combined_objects_networking, {})
  # subnet_id         = try(each.value.vnet_key, null) == null ? null : try(local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, local.combined_objects_networking[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  # private_endpoints = try(each.value.private_endpoints, {})
  client_config     = local.client_config
  base_tags         = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

module event_hub_namespaces_diagnostics {
  source   = "./modules/diagnostics"
  for_each = var.event_hub_namespaces

  resource_id       = module.event_hub_namespaces[each.key].id
  resource_location = module.event_hub_namespaces[each.key].location
  diagnostics       = local.diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}

# module private_endpoint {
#   source   = "./modules/networking/private_endpoint"
#   for_each = try(var.private_endpoints, {})

#   resource_id         = azurerm_eventhub_namespace.evh.id
#   name                = each.value.name
#   location            = var.resource_groups[each.value.resource_group_key].location
#   resource_group_name = var.resource_groups[each.value.resource_group_key].name
#   subnet_id           = var.subnet_id
#   settings            = each.value
#   global_settings     = var.global_settings
#   base_tags           = local.tags
# }
