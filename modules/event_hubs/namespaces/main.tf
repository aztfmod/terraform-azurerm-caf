terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}


locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.base_tags, local.module_tag, lookup(var.settings, "tags", {}))

  location       = can(var.settings.region) ? var.global_settings.regions[var.settings.region] : var.resource_group.location
}
