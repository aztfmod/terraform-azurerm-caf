terraform {

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"

    }
  }
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = var.base_tags ? merge(
    var.global_settings.tags,
    local.module_tag,
    try(var.resource_group.tags, null),
    try(var.tags, null)
  ) : merge(local.module_tag, try(var.tags, null))

  resource_group_name = coalesce(var.resource_group_name, try(var.resource_group.name, null))
}
