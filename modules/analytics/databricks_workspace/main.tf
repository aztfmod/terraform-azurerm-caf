locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags     = merge(var.base_tags, local.module_tag, try(var.settings.tags, null))
  location = can(var.settings.region) ? var.global_settings.regions[var.settings.region] : var.resource_group.location
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}
