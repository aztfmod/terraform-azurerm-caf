terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }
}

locals {
  tags = var.inherit_tags ? var.tags : try(var.settings.tags, null)
}