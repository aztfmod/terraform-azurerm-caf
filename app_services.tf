# Tested with :  AzureRM version 2.55.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/

module "app_services" {
  source     = "./modules/webapps/appservice"
  depends_on = [module.networking]
  for_each   = local.webapp.app_services

  name                                = each.value.name
  client_config                       = local.client_config
  app_service_plan_id                 = can(each.value.app_service_plan_id) ? each.value.app_service_plan_id : local.combined_objects_app_service_plans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.app_service_plan_key].id
  settings                            = each.value.settings
  identity                            = try(each.value.identity, null)
  connection_strings                  = try(each.value.connection_strings, {})
  app_settings                        = try(each.value.app_settings, null)
  slots                               = try(each.value.slots, {})
  global_settings                     = local.global_settings
  dynamic_app_settings                = try(each.value.dynamic_app_settings, {})
  combined_objects                    = local.dynamic_app_settings_combined_objects
  application_insight                 = try(each.value.application_insight_key, null) == null ? null : module.azurerm_application_insights[each.value.application_insight_key]
  diagnostic_profiles                 = try(each.value.diagnostic_profiles, null)
  diagnostics                         = local.combined_diagnostics
  storage_accounts                    = local.combined_objects_storage_accounts
  private_endpoints                   = try(each.value.private_endpoints, {})
  vnets                               = local.combined_objects_networking
  subnet_id                           = can(each.value.subnet_id) || can(each.value.vnet_key) == false ? try(each.value.subnet_id, null) : local.combined_objects_networking[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  private_dns                         = local.combined_objects_private_dns
  azuread_applications                = local.combined_objects_azuread_applications
  azuread_service_principal_passwords = local.combined_objects_azuread_service_principal_passwords

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
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

resource "azurerm_app_service_slot_virtual_network_swift_connection" "vnet_config" {
  for_each = {
    for mapping in
    flatten(
      [
        for key, app_service in local.webapp.app_services : [
          for slot_key, slot in try(app_service.slots, {}) :
          {
            key            = key
            slot_key       = slot_key
            slot_name      = module.app_services[key].slot[slot_key].name
            app_service_id = module.app_services[key].id
            subnet_id      = local.combined_objects_networking[try(app_service.vnet_integration.lz_key, local.client_config.landingzone_key)][app_service.vnet_integration.vnet_key].subnets[app_service.vnet_integration.subnet_key].id
          }
        ]
      ]
    ) : format("%s_%s", mapping.key, mapping.slot_key) => mapping
  }

  slot_name      = each.value.slot_name
  app_service_id = each.value.app_service_id
  subnet_id      = each.value.subnet_id
}
