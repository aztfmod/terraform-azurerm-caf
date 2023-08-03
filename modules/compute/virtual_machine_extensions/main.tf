terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

data "azapi_resource_action" "azurerm_virtual_machine_status" {
  type                   = "Microsoft.Compute/virtualMachines@2022-11-01"
  resource_id            = var.virtual_machine_id
  action                 = "instanceView"
  method                 = "GET"
  response_export_values = ["statuses"]
}

data "azurecaf_environment_variable" "token" {
  count = can(var.extension.pats_from_env_variable.variable_name) ? 1 : 0

  name           = var.extension.pats_from_env_variable.variable_name
  fails_if_empty = true
}