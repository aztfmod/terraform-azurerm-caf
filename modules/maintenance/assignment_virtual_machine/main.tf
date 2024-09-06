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
  tags     = merge(var.base_tags, local.module_tag, try(var.tags, null))
  location = var.location
}