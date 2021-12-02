terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

# resource "time_sleep" "delay_create" {
#   depends_on = [azurerm_data_protection_backup_vault.backup_vault]

#   create_duration = "30s"
# }
