output "id" {
  description = "The ID of the Storage Blob"
  value       = azurerm_storage_blob.blob.id
}

output "url" {
  description = "The URL of the blob"
  value       = azurerm_storage_blob.blob.url
}
