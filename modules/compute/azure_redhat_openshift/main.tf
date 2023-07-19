terraform {
  # required_version = ">= 1.0"
  required_providers {
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.7.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.base_tags, local.module_tag, try(var.settings.tags, null))
}
