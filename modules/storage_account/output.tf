output "id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.stg.id
}

output "name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.stg.name
}

output "location" {
  description = "The location of the Storage Account"
  value       = var.location
}

output "resource_group_name" {
  description = "The resource group name of the Storage Account"
  value       = var.resource_group_name
}

output "primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = azurerm_storage_account.stg.primary_blob_endpoint
}

output "containers" {
  value = module.container
}

output "data_lake_filesystems" {
  value = module.data_lake_filesystem
}

output "file_share" {
  value = module.file_share
}

output "identity" {
  description = " An identity block, which contains the Identity information for this Storage Account. Exports principal_id (The Principal ID for the Service Principal associated with the Identity of this Storage Account), tenand_id (The Tenant ID for the Service Principal associated with the Identity of this Storage Account)"
  value       = try(azurerm_storage_account.stg.identity, null)
}

output "rbac_id" {
  description = " An identity block, which contains the Identity information for this Storage Account. Exports principal_id (The Principal ID for the Service Principal associated with the Identity of this Storage Account), tenand_id (The Tenant ID for the Service Principal associated with the Identity of this Storage Account)"
  value       = try(azurerm_storage_account.stg.identity.0, null)
}

output "backup_container_id" {
  description = "The ID of the Backup Storage Account Container"
  value       = try(azurerm_backup_container_storage_account.container["enabled"].id, null)
}