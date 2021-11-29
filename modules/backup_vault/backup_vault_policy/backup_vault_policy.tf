resource "azurerm_data_protection_backup_policy_blob_storage" "backup_vault_policy" {
  for_each = try(var.settings.backup_vault_policies, {})
  
  name                                             = each.value.name
  backup_vault_name                                = azurerm_data_protection_backup_vault.backup_vault.name
  retention_duration                               = each.value.retention_duration #try(var.backup_vault.policy, "P30D")
}
