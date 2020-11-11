terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(local.module_tag, try(var.settings.tags, null), var.base_tags)

  databases = [
    for key, value in var.settings.databases : var.databases[try(value.lz_key, var.client_config.landingzone_key)][key].id
  ]
}