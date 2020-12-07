locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(local.module_tag, try(var.settings.tags, null), var.base_tags)
}


terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}


resource "time_sleep" "delay_create" {
  depends_on = [azurerm_resource_group_template_deployment.asr]

  create_duration = "60s"
}