output "id" {
  description = "The ID of the Backup Vault"
  value       = azurerm_data_protection_backup_vault.backup_vault.id
}

output "name" {
  depends_on  = [azurerm_data_protection_backup_vault.backup_vault]
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

output "backup_vault_policies"{
  description = "The backup vault policies output objects as created by the backup vault policies submodule."
  values      = module.backup_vault_policy
}

output "datastore_type" {
  description = "Output of the datastore type on the resource."
  value       = try(var.backup_vault.datastore_type, null)
}

output "redundancy" {
  description = "Output of the datastore type on the resource."
  value       = try(var.backup_vault.redundancy, null)
}

output "identity" {
  description = " An identity block, which contains the Identity information for this Backup Vault. Exports principal_id (The Principal ID for the Service Principal associated with the Identity of this Backup Vault), tenand_id (The Tenant ID for the Service Principal associated with the Identity of this Backup Vault)"
  value       = try(azurerm_data_protection_backup_vault.backup_vault.identity, null)
}
output "rbac_id" {
  description = " The Principal ID for the Service Principal associated with the Identity of this Backup Vault. (Extracted from the identity block)"
  value       = try(azurerm_data_protection_backup_vault.backup_vault.identity.0.principal_id, null)
}
