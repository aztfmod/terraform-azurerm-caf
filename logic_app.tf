##### azurerm_integration_service_environment
module "integration_service_environment" {
  source = "./modules/logic_app/integration_service_environment"

  for_each = local.logic_app.integration_service_environment

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
  vnets               = local.combined_objects_networking
}

output "integration_service_environment" {
  value = module.integration_service_environment
}

##### azurerm_logic_app_action_custom
module "logic_app_action_custom" {
  source = "./modules/logic_app/action_custom"

  for_each = local.logic_app.logic_app_action_custom

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  logic_app_id    = try(local.combined_objects_logic_app_workflow[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.logic_app_key].id, null)
}

output "logic_app_action_custom" {
  value = module.logic_app_action_custom
}

##### azurerm_logic_app_action_http
module "logic_app_action_http" {
  source = "./modules/logic_app/action_http"

  for_each = local.logic_app.logic_app_action_http

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  logic_app_id    = try(local.combined_objects_logic_app_workflow[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.logic_app_key].id, null)
}

output "logic_app_action_http" {
  value = module.logic_app_action_http
}

##### azurerm_logic_app_integration_account
module "logic_app_integration_account" {
  source = "./modules/logic_app/integration_account"

  for_each = local.logic_app.logic_app_integration_account

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}

}

output "logic_app_integration_account" {
  value = module.logic_app_integration_account
}

##### azurerm_logic_app_trigger_custom
module "logic_app_trigger_custom" {
  source = "./modules/logic_app/trigger_custom"

  for_each = local.logic_app.logic_app_trigger_custom

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  logic_app_id    = try(local.combined_objects_logic_app_workflow[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.logic_app_key].id, null)
}

output "logic_app_trigger_custom" {
  value = module.logic_app_trigger_custom
}

##### azurerm_logic_app_trigger_http_request
module "logic_app_trigger_http_request" {
  source = "./modules/logic_app/trigger_http_request"

  for_each = local.logic_app.logic_app_trigger_http_request

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  logic_app_id    = try(local.combined_objects_logic_app_workflow[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.logic_app_key].id, null)
}

output "logic_app_trigger_http_request" {
  value = module.logic_app_trigger_http_request
}

##### azurerm_logic_app_trigger_recurrence
module "logic_app_trigger_recurrence" {
  source = "./modules/logic_app/trigger_recurrence"

  for_each = local.logic_app.logic_app_trigger_recurrence

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  logic_app_id    = try(local.combined_objects_logic_app_workflow[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.logic_app_key].id, null)
}

output "logic_app_trigger_recurrence" {
  value = module.logic_app_trigger_recurrence
}

##### azurerm_logic_app_workflow
module "logic_app_workflow" {
  source   = "./modules/logic_app/workflow"
  for_each = local.logic_app.logic_app_workflow

  global_settings                    = local.global_settings
  client_config                      = local.client_config
  settings                           = each.value
  location                           = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name                = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags                          = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
  integration_service_environment_id = try(local.combined_objects_integration_service_environment[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.integration_service_environment_key].id, null)
  logic_app_integration_account_id   = try(local.combined_objects_logic_app_integration_account[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.logic_app_integration_account_key].id, null)
}

output "logic_app_workflow" {
  value = module.logic_app_workflow
}

module "logic_app_standard" {
  source     = "./modules/logic_app/standard"
  depends_on = [module.networking, module.storage_accounts]
  for_each   = local.logic_app.logic_app_standard

  name                 = each.value.name
  client_config        = local.client_config
  dynamic_app_settings = try(each.value.dynamic_app_settings, {})
  app_settings         = try(each.value.app_settings, null)
  combined_objects     = local.dynamic_app_settings_combined_objects
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].name, null),
    try(each.value.resource_group.name, null)
  )
  location                   = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  app_service_plan_id        = try(each.value.lz_key, null) == null ? local.combined_objects_app_service_plans[local.client_config.landingzone_key][each.value.app_service_plan_key].id : local.combined_objects_app_service_plans[each.value.lz_key][each.value.app_service_plan_key].id
  settings                   = each.value.settings
  application_insight        = try(each.value.application_insight_key, null) == null ? null : module.azurerm_application_insights[each.value.application_insight_key]
  identity                   = try(each.value.identity, null)
  connection_strings         = try(each.value.connection_strings, {})
  storage_account_name       = try(data.azurerm_storage_account.logic_app[each.key].name, null)
  storage_account_access_key = try(data.azurerm_storage_account.logic_app[each.key].primary_access_key, null)
  # subnet_id = try(
  #                 each.value.subnet_id,
  #                 local.combined_objects_networking[try(each.value.settings.lz_key, local.client_config.landingzone_key)][each.value.settings.vnet_key].subnets[each.value.settings.subnet_key].id,
  #                 null
  #                 )
  global_settings = local.global_settings
  base_tags       = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  tags            = try(each.value.tags, null)

  remote_objects = {
    subnets = try(local.combined_objects_networking[try(each.value.settings.lz_key, local.client_config.landingzone_key)][each.value.settings.vnet_key].subnets, null)
  }
}

output "logic_app_standard" {
  value = module.logic_app_standard
}

data "azurerm_storage_account" "logic_app" {
  depends_on = [module.storage_accounts]
  for_each = {
    for key, value in local.logic_app.logic_app_standard : key => value
    if try(value.storage_account_key, null) != null
  }

  name                = module.storage_accounts[each.value.storage_account_key].name
  resource_group_name = module.storage_accounts[each.value.storage_account_key].resource_group_name
}
