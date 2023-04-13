terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azapi = {
      source = "azure/azapi"
    }
  }

}

locals {

  settings = var.settings
}