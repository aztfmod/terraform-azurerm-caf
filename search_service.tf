module "azurerm_search_service" {
  source   = "./modules/cognitive_services/search_service"
  for_each = local.cognitive_services.azurerm_search_service

  base_tags           = local.global_settings.inherit_tags
  client_config       = local.client_config
  global_settings     = local.global_settings
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  resource_groups     = local.combined_objects_resource_groups
  settings            = each.value
  vnets               = local.combined_objects_networking
}

output "search_service" {
  value = module.azurerm_search_service
}
