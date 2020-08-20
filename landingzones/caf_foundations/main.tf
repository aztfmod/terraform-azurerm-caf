terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.23.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 0.11.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 2.2.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~>0.4.3"
    }
  }
  required_version = ">= 0.13"
}


provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

data "terraform_remote_state" "launchpad" {
  backend = "azurerm"
  config = {
    storage_account_name = var.lowerlevel_storage_account_name
    container_name       = var.lowerlevel_container_name
    key                  = var.lowerlevel_key
    resource_group_name  = var.lowerlevel_resource_group_name
  }
}

locals {
  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  diagnostics     = data.terraform_remote_state.launchpad.outputs.diagnostics
}
