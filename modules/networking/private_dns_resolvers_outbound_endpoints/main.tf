terraform {
  required_providers {
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }

}

locals {
  tags = var.inherit_tags ? merge(
    var.global_settings.tags,
    var.tags
  ) : null
  location = coalesce(var.location)
}
