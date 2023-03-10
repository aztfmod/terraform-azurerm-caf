# terraform provider: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/static_site

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

  tags = merge(var.base_tags, local.module_tag, var.tags)
}
