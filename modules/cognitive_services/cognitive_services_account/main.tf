terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
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
    var.global_settings.tags,
    try(var.settings.tags, null)
  ) : try(var.settings.tags, null)
}
