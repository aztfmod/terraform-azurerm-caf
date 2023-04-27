terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}
locals {
  base_tags = try(var.global_settings.inherit_tags, false) ? try(var.keyvaults.base_tags, {}) : {}
  tags      = merge(local.base_tags, try(var.settings.tags, {}))
}