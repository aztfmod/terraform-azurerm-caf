terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.48"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    azuread = {
      source = "hashicorp/azuread"
    }
    random = {
      version = "~> 3.3.1"
      source  = "hashicorp/random"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
  }
}

data "azuread_domains" "aad_domains" {
  only_initial = true
}
