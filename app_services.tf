
module "app_services" {
  source     = "./modules/webapps/appservice"
  depends_on = [module.networking]
  for_each   = local.webapp.app_services

  name                 = each.value.name
  client_config        = local.client_config
  resource_group_name  = local.resource_groups[each.value.resource_group_key].name
  location             = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  app_service_plan_id  = try(each.value.lz_key, null) == null ? local.combined_objects_app_service_plans[local.client_config.landingzone_key][each.value.app_service_plan_key].id : local.combined_objects_app_service_plans[each.value.lz_key][each.value.app_service_plan_key].id
  settings             = each.value.settings
  identity             = try(each.value.identity, null)
  connection_strings   = try(each.value.connection_strings, {})
  app_settings         = try(each.value.app_settings, null)
  slots                = try(each.value.slots, {})
  global_settings      = local.global_settings
  dynamic_app_settings = try(each.value.dynamic_app_settings, {})
  combined_objects     = local.dynamic_app_settings_combined_objects
  base_tags            = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  application_insight  = try(each.value.application_insight_key, null) == null ? null : module.azurerm_application_insights[each.value.application_insight_key]
  diagnostic_profiles  = try(each.value.diagnostic_profiles, null)
  diagnostics          = local.combined_diagnostics
  storage_accounts     = local.combined_objects_storage_accounts
  subnet_id            = try(local.combined_objects_networking[try(each.value.vnet_integration.lz_key, local.client_config.landingzone_key)][each.value.vnet_integration.vnet_key].subnets[each.value.vnet_integration.subnet_key].id, null)
  tags                 = try(each.value.tags, null)
}

output "app_services" {
  value = module.app_services
}
