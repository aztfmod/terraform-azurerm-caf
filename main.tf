
terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}

locals {
  diagnostics = {
    diagnostics_definition   = var.diagnostics_definition == null ? var.diagnostics.diagnostics_definition : var.diagnostics_definition
    diagnostics_destinations = var.diagnostics_destinations == null ? var.diagnostics.diagnostics_destinations : var.diagnostics_destinations
    storage_accounts         = length(module.storage_accounts) == 0 ? var.diagnostics.storage_accounts : module.storage_accounts
    log_analytics            = length(module.log_analytics) == 0 ? var.diagnostics.log_analytics : module.log_analytics
  }
}