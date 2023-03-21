terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

locals {
  tags = var.inherit_tags ? var.tags : try(var.settings.tags, null)
}