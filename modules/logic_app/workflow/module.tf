# Resorce type doesn't "azurerm_logic_app_workflow" doesn't exist in azurecaf!!
# resource "azurecaf_name" "logic_app" {
#   name          = var.name
#   resource_type = "azurerm_logic_app_workflow"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_logic_app_workflow" "la" {
  name                               = var.name
  location                           = var.location
  resource_group_name                = var.resource_group_name
  integration_service_environment_id = var.integration_service_environment_id
  logic_app_integration_account_id   = var.logic_app_integration_account_id
  workflow_schema                    = var.workflow_schema
  workflow_version                   = var.workflow_version
  parameters                         = var.parameters
  tags                               = merge(var.tags, var.base_tags)
}


