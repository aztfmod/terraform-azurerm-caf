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
  arm_filename = "${path.module}/arm_domain.json"
  tags         = merge(local.module_tag, try(var.settings.tags, null), var.base_tags)
}
