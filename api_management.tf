module "api_management" {
  source   = "./modules/api_management_services/api_management"
  for_each = local.api_management_services.api_management

  client_config       = local.client_config
  global_settings     = local.global_settings
  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  settings            = each.value
}

output "api_management" {
  value = module.api_management
}