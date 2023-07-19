terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

# locals {
#   module_tag = {
#     "module" = basename(abspath(path.module))
#   }
#   tags = merge(var.tags, local.module_tag)
# }
