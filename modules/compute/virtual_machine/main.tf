terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}


locals {
  os_type = lower(var.settings.os_type)
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = var.base_tags ? merge(
    var.global_settings.tags,
    try(var.resource_group.tags, null),
    local.module_tag,
    try(var.settings.tags, null)
    ) : merge(
    local.module_tag,
    try(var.settings.tags,
    null)
  )

  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}