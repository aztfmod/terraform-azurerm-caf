terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    null = {
      source = "hashicorp/null"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
}

locals {
  tags = var.inherit_tags ? var.tags : try(var.settings.tags, null)
}
