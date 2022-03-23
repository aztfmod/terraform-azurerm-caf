terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  location = coalesce(
    try(var.settings.location, null),
    try(var.remote_objects.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].location, null),
    try(var.remote_objects.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].location, null)
  )
  resource_group_name = coalesce(
    try(var.remote_objects.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].name, null),
    try(var.remote_objects.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].name, null)
  )
  base_tags = try(var.global_settings.inherit_tags, false) ? coalesce(
    try(var.remote_objects.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].tags, null),
    try(var.remote_objects.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].tags, null)
  ) : {}
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  resource_group = coalesce(
    try(var.remote_objects.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key], null),
    try(var.remote_objects.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key], null)
  )
}