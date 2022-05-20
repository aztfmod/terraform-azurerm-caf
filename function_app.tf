module "function_apps" {
  source     = "./modules/webapps/function_app"
  depends_on = [module.networking]
  for_each   = local.webapp.function_apps

  name                       = each.value.name
  client_config              = local.client_config
  dynamic_app_settings       = try(each.value.dynamic_app_settings, {})
  app_settings               = try(each.value.app_settings, null)
  combined_objects           = local.dynamic_app_settings_combined_objects
  resource_group_name        = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  location                   = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  app_service_plan_id        = can(each.value.app_service_plan_id) || can(each.value.app_service_plan_key) == false ? try(each.value.app_service_plan_id, null) : local.combined_objects_app_service_plans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.app_service_plan_key].id
  settings                   = each.value.settings
  application_insight        = try(each.value.application_insight_key, null) == null ? null : module.azurerm_application_insights[each.value.application_insight_key]
  identity                   = try(each.value.identity, null)
  connection_strings         = try(each.value.connection_strings, {})
  storage_account_name       = try(data.azurerm_storage_account.function_apps[each.key].name, null)
  storage_account_access_key = try(data.azurerm_storage_account.function_apps[each.key].primary_access_key, null)
  # subnet_id = try(
  #                 each.value.subnet_id,
  #                 local.combined_objects_networking[try(each.value.settings.lz_key, local.client_config.landingzone_key)][each.value.settings.vnet_key].subnets[each.value.settings.subnet_key].id,
  #                 null
  #                 )
  global_settings = local.global_settings
  base_tags       = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

  tags = try(each.value.tags, null)

  remote_objects = {
    subnets = try(local.combined_objects_networking[try(each.value.settings.lz_key, local.client_config.landingzone_key)][each.value.settings.vnet_key].subnets, null)
  }
}

output "function_apps" {
  value = module.function_apps
}

data "azurerm_storage_account" "function_apps" {
  for_each = {
    for key, value in local.webapp.function_apps : key => value
    if try(value.storage_account_key, null) != null
  }

  name                = module.storage_accounts[each.value.storage_account_key].name
  resource_group_name = module.storage_accounts[each.value.storage_account_key].resource_group_name
}