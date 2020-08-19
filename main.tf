
terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.1"
    }
  }
  required_version = ">= 0.13"
}

data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}

resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
  number  = false
}

resource "random_string" "alpha1" {
  length  = 1
  special = false
  upper   = false
  number  = false
}

locals {
  diagnostics = {
    diagnostics_definition   = lookup(var.diagnostics, "diagnostics_definition", var.diagnostics_definition)
    diagnostics_destinations = lookup(var.diagnostics, "diagnostics_destinations", var.diagnostics_destinations)
    storage_accounts         = lookup(var.diagnostics, "storage_accounts", module.storage_accounts)
    log_analytics            = lookup(var.diagnostics, "log_analytics", module.log_analytics)
  }

  prefix = lookup(var.global_settings, "prefix", null) == null ? random_string.prefix.result : var.global_settings.prefix

  global_settings = {
    prefix             = local.prefix
    prefix_with_hyphen = local.prefix == "" ? "" : "${local.prefix}-"
    prefix_start_alpha = local.prefix == "" ? "" : "${random_string.alpha1.result}${local.prefix}"
    convention         = lookup(var.global_settings, "convention", var.convention)
    default_region     = lookup(var.global_settings, "default_region", "region1")
    environment        = lookup(var.global_settings, "environment", var.environment)
    max_length         = lookup(var.global_settings, "max_length", var.max_length)
    regions            = var.global_settings.regions
  }
}