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
    try(var.tags, null)
    ) : merge(
    try(var.tags,
    null)
  )


}
