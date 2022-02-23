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
  base_tags = try(var.global_settings.inherit_tags, false) ? try(var.keyvault.base_tags, {}) : {}
  tags      = merge(local.base_tags, local.module_tag, try(var.settings.tags, {}))
}