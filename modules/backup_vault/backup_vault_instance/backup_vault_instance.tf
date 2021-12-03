resource "azurerm_data_protection_backup_instance_blob_storage" "backup_vault_instance" {
  
  name               = var.settings.name
#   vault_id           = var.vault_id
#   location           = var.location
#   storage_account_id = azurerm_storage_account.stg.id
#   backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.backup_vault_policy.id
}
