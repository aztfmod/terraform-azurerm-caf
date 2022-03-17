terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags           = merge(var.base_tags, local.module_tag, var.tags)
  location       = can(var.settings.region) ? var.global_settings.regions[var.settings.region] : local.resource_group.location
  resource_group = var.resource_groups[try(var.settings.resource_group.lz_key,var.settings.lz_key,var.client_config.landingzone_key)][try(var.settings.resource_group_key,var.settings.resource_group.key)]
}