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

  tags = merge(
    var.base_tags,
    local.module_tag,
    var.global_settings.tags,
    try(var.settings.tags, null)
  )
}
