terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  arm_filename = "${path.module}/arm_domain.json"
  tags         = merge(var.base_tags, local.module_tag, try(var.settings.tags, null))
}
