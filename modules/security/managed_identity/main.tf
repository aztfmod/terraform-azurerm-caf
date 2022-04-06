terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  tags = merge(var.base_tags, try(var.settings.tags, null))
}
