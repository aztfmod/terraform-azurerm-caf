locals {
  base_tags           = try(var.global_settings.inherit_tags, false) ? var.resource_group.tags : {}
  location            = lookup(var.settings, "region", null) == null ? var.resource_group.location : var.global_settings.regions[var.settings.region]
  resource_group_name = var.resource_group.name
}
