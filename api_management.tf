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
    managed_identities  = local.combined_objects_managed_identities
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

module "api_management_api_diagnostic" {
  source   = "./modules/apim/api_management_api_diagnostic"
  for_each = local.apim.api_management_api_diagnostic

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

    api_management_logger_id = coalesce(
        try(local.combined_objects_api_management_logger[each.value.api_management_logger.lz_key][each.value.api_management_logger.key].id, null),
        try(local.combined_objects_api_management_logger[local.client_config.landingzone_key][each.value.api_management_logger.key].id, null),
        try(each.value.api_management_logger.id, null)
    )

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
        api_management_logger = local.combined_objects_api_management_logger
        api_management = local.combined_objects_api_management
        resource_group = local.combined_objects_resource_groups
  }
}
output "api_management_api_diagnostic" {
  value = module.api_management_api_diagnostic
}
module "api_management_logger" {
  source   = "./modules/apim/api_management_logger"
  for_each = local.apim.api_management_logger

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

    resource_group_name = coalesce(
        try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
        try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
        try(each.value.resource_group.name, null)
    )

    api_management_name = coalesce(
        try(local.combined_objects_api_management[each.value.api_management.lz_key][each.value.api_management.key].name, null),
        try(local.combined_objects_api_management[local.client_config.landingzone_key][each.value.api_management.key].name, null),
        try(each.value.api_management.name, null)
    )


  remote_objects = {
        resource_group = local.combined_objects_resource_groups
        api_management = local.combined_objects_api_management
  }
}
output "api_management_logger" {
  value = module.api_management_logger
}
module "api_management_api_operation" {
  source   = "./modules/apim/api_management_api_operation"
  for_each = local.apim.api_management_api_operation

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

    api_name = coalesce(
        try(local.combined_objects_api_management_api[each.value.api.lz_key][each.value.apit.key].name, null),
        try(local.combined_objects_api_management_api[local.client_config.landingzone_key][each.value.api.key].name, null),
        try(each.value.api.name, null)
    )

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
output "api_management_api_operation" {
  value = module.api_management_api_operation
}