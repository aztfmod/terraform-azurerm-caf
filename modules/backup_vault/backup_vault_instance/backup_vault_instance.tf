resource "azurerm_data_protection_backup_instance_blob_storage" "backup_vault_instance" {
#   for_each = try(var.settings.backup_vault_instances, {})
  
  name               = var.settings.instance_name
  vault_id           = var.vault_id
  location           = var.location
  storage_account_id = var.storage_account_id_test
  backup_policy_id   = var.backup_policy_id
}
