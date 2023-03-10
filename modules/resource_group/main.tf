terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
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