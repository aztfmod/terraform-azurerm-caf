terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azapi = {
      source = "azure/azapi"
    }
  }

}

locals {
  tags = var.base_tags ? merge(
    var.global_settings.tags,
    var.server_tags
  ) : null



}