resource "azurerm_data_protection_backup_instance_blob_storage" "backup_vault_instance" {
  for_each = try(var.settings.backup_vault_instances, {})
  
  name               = var.settings.name
  vault_id           = var.vault_id
  location           = var.location
  storage_account_id = var.storage_account_id
  backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.backup_vault_policy[each.value.backup_vault_policy_key].id
}
