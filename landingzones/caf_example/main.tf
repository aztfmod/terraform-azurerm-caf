terraform {
  required_providers {
  }
  required_version = ">= 0.13"
}


provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = var.provider_azurerm_features_keyvault.purge_soft_delete_on_destroy
    }
  }
}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }

  tags = merge(local.landingzone_tag, var.tags, { "rover_version" = var.rover_version })
}