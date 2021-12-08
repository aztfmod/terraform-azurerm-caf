terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  resource_group = coalesce(
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group_key], null),
    try(var.resource_groups[var.settings.lz_key][var.settings.resource_group_key], null),
    try(var.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key], null),
    try(var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key], null)
  )
}