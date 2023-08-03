output "id" {
  description = "The ID of the Storage Blob"
  value       = azurerm_storage_blob.blob.id
}

output "url" {
  description = "The URL of the blob"
  value       = azurerm_storage_blob.blob.url
}

output "rbac_id" {
  description = "The ID of the Storage Blob for role_mapping"
  value       = azurerm_storage_blob.blob.id
}
