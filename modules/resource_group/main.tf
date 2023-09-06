terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  tags = var.global_settings.inherit_tags ? merge(
    var.global_settings.tags,
    var.tags
  ) : var.tags
}