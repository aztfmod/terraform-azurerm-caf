terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }

}
locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  base_tags = try(var.global_settings.inherit_tags, false) ? try(var.keyvault.base_tags, {}) : {}
  tags      = merge(local.base_tags, local.module_tag, try(var.settings.tags, {}))
}
