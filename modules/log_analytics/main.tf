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
  tags = merge(local.module_tag, lookup(var.log_analytics, "tags", {}), var.base_tags)
}
