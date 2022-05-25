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

output "primary_access_key" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = azurerm_storage_account.stg.primary_access_key
  sensitive   = true
}

output "containers" {
  description = "The containers output objects as created by the container submodule."
  value       = module.container
}

output "queues" {
  description = "The queues output objects as created by the queues submodule."
  value       = module.queue
}

output "data_lake_filesystems" {
  description = "The data lake filesystem output objects as created by the data lake filesystem submodule."
  value       = module.data_lake_filesystem
}

output "file_share" {
  description = "The file shares output objects as created by the file shares submodule."
  value       = module.file_share
}

output "identity" {
  description = " An identity block, which contains the Identity information for this Storage Account. Exports principal_id (The Principal ID for the Service Principal associated with the Identity of this Storage Account), tenand_id (The Tenant ID for the Service Principal associated with the Identity of this Storage Account)"
  value       = try(azurerm_storage_account.stg.identity, null)
}

output "rbac_id" {
  description = " The Principal ID for the Service Principal associated with the Identity of this Storage Account. (Extracted from the identity block)"
  value       = try(azurerm_storage_account.stg.identity.0.principal_id, null)
}

output "backup_container_id" {
  description = "The ID of the Backup Storage Account Container"
  value       = try(azurerm_backup_container_storage_account.container["enabled"].id, null)
}


output "primary_web_host" {
  description = "The hostname with port if applicable for web storage in the primary location."
  value       = azurerm_storage_account.stg.primary_web_host
}

output "primary_connection_string" {
  value     = try(azurerm_storage_account.stg.primary_connection_string, null)
  sensitive = true
}


output "primary_blob_connection_string" {
  value     = try(azurerm_storage_account.stg.primary_blob_connection_string, null)
  sensitive = true
}

#output "primary_queue_endpoint" {
#  value = try(azurerm_storage_account.stg.primary_queue_endpoint, null)
#}