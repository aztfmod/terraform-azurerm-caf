terraform {
  required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.48"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }

}

locals {
  tags = var.base_tags ? merge(
    var.global_settings.tags,
    # try(local.resource_group.tags, null),
    try(var.settings.tags, null)
    ) : merge(
    try(var.settings.tags,
    null)
  )

  # location            = coalesce(var.location, var.resource_group.location)
  # resource_group = var.resource_groups[try(each.value.lz_key, var.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)]
}
