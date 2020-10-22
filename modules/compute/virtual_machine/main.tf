terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}


locals {
  os_type = lower(var.settings.os_type)
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(local.module_tag, try(var.settings.tags, null), var.base_tags)
}