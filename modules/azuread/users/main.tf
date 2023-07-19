terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    random = {
      source = "hashicorp/random"
    }
    time = {
      source = "hashicorp/time"
    }
  }
}

data "azuread_domains" "aad_domains" {
  only_initial = true
}
