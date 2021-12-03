output "id" {
  description = "The Resource Manager ID of this Backup Vault Policy."
  value       = azurerm_data_protection_backup_policy_blob_storage.backup_vault_policy.id
}
