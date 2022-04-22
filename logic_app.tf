##### azurerm_integration_service_environment
module "integration_service_environment" {
  source = "./modules/logic_app/integration_service_environment"

  for_each = local.logic_app.integration_service_environment

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
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
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

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
  base_tags                          = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  integration_service_environment_id = try(local.combined_objects_integration_service_environment[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.integration_service_environment_key].id, null)
  logic_app_integration_account_id   = try(local.combined_objects_logic_app_integration_account[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.logic_app_integration_account_key].id, null)
}

output "logic_app_workflow" {
  value = module.logic_app_workflow
}
