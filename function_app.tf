
module "function_apps" {
  source = "./modules/webapps/function_app"

  for_each = local.webapp.function_apps

  name                        = each.value.name
  client_config               = local.client_config
  dynamic_app_settings        = try(each.value.dynamic_app_settings, {})
  combined_objects            = local.dynamic_app_settings_combined_objects
  resource_group_name         = module.resource_groups[each.value.resource_group_key].name
  location                    = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  app_service_plan_id         = try(each.value.lz_key, null) == null ? local.combined_objects_app_service_plans[local.client_config.landingzone_key][each.value.app_service_plan_key].id : local.combined_objects_app_service_plans[each.value.lz_key][each.value.app_service_plan_key].id
  settings                    = each.value.settings
  application_insight         = try(each.value.application_insight_key, null) == null ? null : module.azurerm_application_insights[each.value.application_insight_key]
  identity                    = try(each.value.identity, null)
  connection_strings          = try(each.value.connection_strings, {})
  storage_account_name        = try(each.value.storage_account_key) == null ? null : module.storage_accounts[each.value.storage_account_key].name
  storage_account_access_key  = try(each.value.storage_account_key) == null ? null : module.storage_accounts[each.value.storage_account_key].primary_access_key
  global_settings             = local.global_settings
  base_tags                   = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  tags                        = try(each.value.tags, null)
}

output "function_apps" {
  value = module.function_apps
}
