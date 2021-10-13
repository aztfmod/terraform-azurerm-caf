terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

locals {
  base_tags = try(var.global_settings.inherit_tags, false) ? coalesce(
    try(var.remote_objects.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].tags, null),
    try(var.remote_objects.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].tags, null)
  ) : {}
}