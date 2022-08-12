# Tested with :  AzureRM version 2.55.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/

module "app_services" {
  source     = "./modules/webapps/appservice"
  depends_on = [module.networking]
  for_each   = local.webapp.app_services

  name                 = each.value.name
  client_config        = local.client_config
  location             = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name  = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  app_service_plan_id  = can(each.value.app_service_plan_id) ? each.value.app_service_plan_id : local.combined_objects_app_service_plans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.app_service_plan_key].id
  settings             = each.value.settings
  identity             = try(each.value.identity, null)
  connection_strings   = try(each.value.connection_strings, {})
  app_settings         = try(each.value.app_settings, null)
  slots                = try(each.value.slots, {})
  global_settings      = local.global_settings
  dynamic_app_settings = try(each.value.dynamic_app_settings, {})
  combined_objects     = local.dynamic_app_settings_combined_objects
  base_tags            = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  application_insight  = try(each.value.application_insight_key, null) == null ? null : module.azurerm_application_insights[each.value.application_insight_key]
  diagnostic_profiles  = try(each.value.diagnostic_profiles, null)
  diagnostics          = local.combined_diagnostics
  storage_accounts     = local.combined_objects_storage_accounts
  tags                 = try(each.value.tags, null)
  private_endpoints    = try(each.value.private_endpoints, {})
  vnets                = local.combined_objects_networking
  subnet_id            = can(each.value.subnet_id) || can(each.value.vnet_key) == false ? try(each.value.subnet_id, null) : local.combined_objects_networking[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  private_dns          = local.combined_objects_private_dns
}

output "app_services" {
  value = module.app_services
}

# Tested with :  AzureRM version 2.55.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/
resource "azurerm_app_service_virtual_network_swift_connection" "vnet_config" {
  for_each = {
    for key, value in local.webapp.app_services : key => value
    if try(value.vnet_integration, null) != null
  }

  app_service_id = module.app_services[each.key].id
  subnet_id      = local.combined_objects_networking[try(each.value.vnet_integration.lz_key, local.client_config.landingzone_key)][each.value.vnet_integration.vnet_key].subnets[each.value.vnet_integration.subnet_key].id
}
