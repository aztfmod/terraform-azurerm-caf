terraform {
  # required_version = ">= 1.0"
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.base_tags, local.module_tag, try(var.settings.tags, null))
}

