data "azurerm_client_config" "current" {}

locals {
  blueprint_tag = {
    "blueprint" = basename(abspath(path.module))
  }
  tags = local.blueprint_tag
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}