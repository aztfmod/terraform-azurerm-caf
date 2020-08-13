
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
    diagnostics_definition = var.diagnostics_definition
    diagnostics_destinations = var.diagnostics_destinations
    storage_accounts       = module.storage_accounts
    log_analytics          = module.log_analytics
  }
}