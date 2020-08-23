terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.24.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 0.11.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.1"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 1.2.0"
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

data "terraform_remote_state" "caf_foundations" {
  backend = "azurerm"
  config = {
    storage_account_name = var.lowerlevel_storage_account_name
    container_name       = var.lowerlevel_container_name
    key                  = "caf_foundations.tfstate"
    resource_group_name  = var.lowerlevel_resource_group_name
  }
}


locals {
  landingzone_tag = {
    "landingzone" = basename(abspath(path.module))
  }
  tags = merge(local.landingzone_tag, { "level" = var.level }, { "environment" = local.global_settings.environment }, { "rover_version" = var.rover_version }, var.tags)

  global_settings = {
    prefix         = try(var.global_settings.prefix, data.terraform_remote_state.caf_foundations.outputs.global_settings.prefix)
    convention     = try(var.global_settings.convention, data.terraform_remote_state.caf_foundations.outputs.global_settings.convention)
    default_region = try(var.global_settings.default_region, data.terraform_remote_state.caf_foundations.outputs.global_settings.default_region)
    regions        = try(var.global_settings.regions, null) == null ? data.terraform_remote_state.caf_foundations.outputs.global_settings.regions : merge(data.terraform_remote_state.caf_foundations.outputs.global_settings.regions, var.global_settings.regions)
    max_length     = try(var.global_settings.max_length, data.terraform_remote_state.caf_foundations.outputs.global_settings.max_length)
    environment    = data.terraform_remote_state.caf_foundations.outputs.global_settings.environment
  }

  diagnostics = {
    diagnostics_definition   = merge(data.terraform_remote_state.caf_foundations.outputs.diagnostics.diagnostics_definition, var.diagnostics_definition)
    diagnostics_destinations = data.terraform_remote_state.caf_foundations.outputs.diagnostics.diagnostics_destinations
    storage_accounts         = data.terraform_remote_state.caf_foundations.outputs.diagnostics.storage_accounts
    log_analytics            = data.terraform_remote_state.caf_foundations.outputs.diagnostics.log_analytics
  }
}
