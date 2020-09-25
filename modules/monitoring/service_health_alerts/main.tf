# locals {
#   module_tag = {
#     "module" = basename(abspath(path.module))
#   }
#   tags = merge(var.global_settings.tags, var.global_settings.module_tag)
# }

terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

