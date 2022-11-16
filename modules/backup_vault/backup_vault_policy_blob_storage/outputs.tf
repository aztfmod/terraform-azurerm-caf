output "id" {
  description = "The ID of the Backup Vault Policy"
  value       = azurerm_data_protection_backup_policy_blob_storage.backup_vault_policy.id
}
