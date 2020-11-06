locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(try(var.settings.tags, {}), local.module_tag, var.base_tags)
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}