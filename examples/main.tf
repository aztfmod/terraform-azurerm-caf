terraform {
  required_providers {
  }
  required_version = ">= 1.1.0"
}


provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = var.provider_azurerm_features_keyvault.purge_soft_delete_on_destroy
    }
  }
}

provider "azurerm" {
  alias                      = "vhub"
  skip_provider_registration = true
  features {}
  subscription_id = data.azurerm_client_config.default.subscription_id
  tenant_id       = data.azurerm_client_config.default.tenant_id
}

data "azurerm_client_config" "default" {}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }

  tags = merge(local.landingzone_tag, var.tags, { "rover_version" = var.rover_version })
}