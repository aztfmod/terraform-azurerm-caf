resource "azurerm_data_protection_backup_policy_blob_storage" "backup_vault_policy" {
  name               = var.settings.policy_name
  vault_id           = var.vault_id
  retention_duration = try(var.settings.retention_duration, "P30D")
}
