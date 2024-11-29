terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

locals {
  tags = var.base_tags ? merge(
    var.global_settings.tags,
    try(var.resource_group.tags, null),
    try(var.settings.tags, null)
  ) : try(var.settings.tags, null)
  # blinQ: Location should be sourced from vnet location if possible, need to be in same region as the vnet. If subnet_id is used insted of vnet_key, then location should be sourced from var.location or at final resource_group location will be tried.
  location            = coalesce(var.location, var.resource_group.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.name)
}