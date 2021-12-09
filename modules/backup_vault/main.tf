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
  required_version = ">= 0.13"
}

resource "time_sleep" "delay_create" {
  depends_on = [azurerm_data_protection_backup_instance_blob_storage.backup_vault]

  create_duration = "60s"
}
