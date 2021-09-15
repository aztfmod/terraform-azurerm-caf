resource "azurecaf_name" "la" {
  name          = var.settings.name
  resource_type = "azurerm_logic_app_workflow"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
# Last review :  AzureRM version 2.74.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow
resource "azurerm_logic_app_workflow" "la" {
  name                               = azurecaf_name.la.result
  resource_group_name                = var.resource_group_name
  location                           = var.location
  integration_service_environment_id = try(var.settings.integration_service_environment_id, null)
  logic_app_integration_account_id   = try(var.settings.logic_app_integration_account_id, null)
  workflow_schema                    = try(var.settings.workflow_schema, null)
  workflow_version                   = try(var.settings.workflow_version, null)
  parameters                         = try(var.settings.parameters, null)
  tags                               = local.tags
}


