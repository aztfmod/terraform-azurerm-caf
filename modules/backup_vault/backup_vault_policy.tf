resource "azurerm_data_protection_backup_policy_blob_storage" "backup_vault_policy" {
  for_each = try(var.settings.backup_vaults.backup_policy, {})
  
  name                                             = each.value.name
  vault_id                                         = azurerm_data_protection_backup_vault.backup_vault.id
  retention_duration                               = try(var.retention_duration, "P30D")
}
