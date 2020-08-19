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
  tags = merge(lookup(var.settings, "tags", {}), local.module_tag)
}

