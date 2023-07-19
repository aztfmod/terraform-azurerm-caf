terraform {
  required_providers {
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.7.0"
    }
  }

}

locals {
  tags = var.base_tags ? merge(
    var.global_settings.tags,
    var.server_tags
  ) : null



}
