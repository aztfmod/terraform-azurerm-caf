output "id" {
  description = "The ID of the Backup Vault"
  value       = azurerm_data_protection_backup_vault.backup_vault.id
}

output "name" {
  description = "The name of the Backup Vault"
  value       = azurerm_data_protection_backup_vault.backup_vault.name
}
output "location" {
  description = "The location of the Backup Vault"
  value       = var.location
}

output "resource_group_name" {
  description = "The resource group name of the Backup Vault"
  value       = var.resource_group_name
}

output "datastore_type" {
  description = "Output of the datastore type on the resource."
  value       = try(var.settings.datastore_type, null)
}

output "redundancy" {
  description = "Output of the datastore type on the resource."
  value       = try(var.settings.redundancy, null)
}

output "identity" {
  description = " An identity block, which contains the Identity information for this Backup Vault. Exports principal_id (The Principal ID for the Service Principal associated with the Identity of this Backup Vault), tenand_id (The Tenant ID for the Service Principal associated with the Identity of this Backup Vault)"
  value       = try(azurerm_data_protection_backup_vault.backup_vault.identity, null)
}
output "rbac_id" {
  description = " The Principal ID for the Service Principal associated with the Identity of this Backup Vault. (Extracted from the identity block)"
  value       = try(azurerm_data_protection_backup_vault.backup_vault.identity.0.principal_id, null)
}
# output "backup_vault_policies"{
#   value = azurerm_data_protection_backup_policy_blob_storage.backup_vault_policy
# }
