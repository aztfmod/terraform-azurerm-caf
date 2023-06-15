terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  tags = var.inherit_tags ? merge(
    var.global_settings.tags
  ) : null
  location            = coalesce(var.location, var.resource_group.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.name)
}