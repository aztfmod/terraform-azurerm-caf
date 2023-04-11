terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  tags = var.inherit_tags ? merge(
    var.global_settings.tags,
    try(var.resource_group.tags, null)
  ) : null
}