terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}


locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
}
