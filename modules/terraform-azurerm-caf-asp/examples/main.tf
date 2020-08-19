terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}


provider "azurerm" {
  features {}
}

module asp {
  source = "/tf/caf"

  global_settings   = var.global_settings
  resource_groups   = var.resource_groups
  app_service_plans = var.app_service_plans
}