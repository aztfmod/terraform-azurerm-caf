locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  # tags = merge(try(each.value.tags, {}), local.module_tag)
}

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}