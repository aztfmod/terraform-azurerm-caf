terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    external = {
      source = "hashicorp/external"
    }
    time = {
      source = "hashicorp/time"
    }
  }

}

locals {
  tags = merge(var.base_tags, try(var.settings.tags, null))
}
