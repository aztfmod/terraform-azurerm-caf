locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.base_tags, local.module_tag, try(var.settings.tags, null))
}


terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

resource "time_sleep" "delay_create" {
  depends_on = [azurerm_recovery_services_vault.asr]

  create_duration = "60s"
}