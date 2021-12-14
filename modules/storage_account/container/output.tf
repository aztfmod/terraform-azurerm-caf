output "blobs" {
  description = "Exports the content of the blob module."
  value       = module.blob
}

output "name" {
  description = "The ID of the Storage Container."
  value       = azurerm_storage_container.stg.name
}

output "resource_manager_id" {
  description = "The Resource Manager ID of this Storage Container."
  value       = azurerm_storage_container.stg.resource_manager_id
}