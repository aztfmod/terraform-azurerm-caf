# locals {
#   module_tag = {
#     "module" = basename(abspath(path.module))
#   }
#   tags = merge(var.base_tags, local.module_tag, try(var.settings.tags, null))
# }


terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

# resource "time_sleep" "delay_p" {
#   depends_on = [azurerm_role_assignment.for]
#   create_duration = "30s"
# }
