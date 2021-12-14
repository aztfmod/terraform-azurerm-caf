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
  # tags = merge(var.base_tags, local.module_tag, var.tags)
  tags = var.tags # temporal use until tag uppercase fixed
}
