module "api_management" {
  source   = "./modules/apim/api_management"
  for_each = local.apim.api_management

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management" {
  value = module.api_management
}

module "api_management_api" {
  source   = "./modules/apim/api_management_api"
  for_each = local.apim.api_management_api

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  api_management_name = coalesce(
    try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
    try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
    try(each.value.api_management.name, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    api_management = local.combined_objects_api_management
    resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_api" {
  value = module.api_management_api
}