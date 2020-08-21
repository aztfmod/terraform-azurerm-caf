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
  tags = merge(var.tags, { "level" = var.level }, { "environment" = var.environment }, { "rover_version" = var.rover_version })

  global_settings = {
    prefix         = data.terraform_remote_state.launchpad.outputs.global_settings.prefix
    convention     = data.terraform_remote_state.launchpad.outputs.global_settings.convention
    default_region = data.terraform_remote_state.launchpad.outputs.global_settings.default_region
    environment    = data.terraform_remote_state.launchpad.outputs.global_settings.environment
    regions        = data.terraform_remote_state.launchpad.outputs.global_settings.regions
    max_length     = var.max_length == null ? data.terraform_remote_state.launchpad.outputs.global_settings.max_length : var.max_length
  }

  diagnostics = {
    diagnostics_definition   = merge(data.terraform_remote_state.launchpad.outputs.diagnostics.diagnostics_definition, var.diagnostics_definition)
    diagnostics_destinations = data.terraform_remote_state.launchpad.outputs.diagnostics.diagnostics_destinations
    storage_accounts         = data.terraform_remote_state.launchpad.outputs.diagnostics.storage_accounts
    log_analytics            = data.terraform_remote_state.launchpad.outputs.diagnostics.log_analytics
  }
}
