terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.7.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.48"
    }
  }
}


locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.base_tags, local.module_tag, try(var.settings.tags, {}))

  resource_group = coalesce(
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group_key], null),
    try(var.resource_groups[var.settings.lz_key][var.settings.resource_group_key], null),
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key], null),
    try(var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key], null)
  )

}
