locals {
  tags = var.base_tags ? merge(
    var.global_settings.tags,
    try(var.resource_groups.tags, null),
    try(var.settings.tags, null)
  ) : try(var.settings.tags, null)


  resource_group = var.resource_groups[try(var.settings.lz_key, var.settings.resource_group.lz_key, var.client_config.landingzone_key)][try(var.settings.resource_group.key, var.settings.resource_group_key)]
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}
