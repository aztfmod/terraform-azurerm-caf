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

output "id" {
  description = "The Resource Manager ID of this Storage Container. Used by role_mapping"
  value       = azurerm_storage_container.stg.resource_manager_id
}

output "url" {
  description = "The Resource Manager ID (URL) of this Storage Container."
  value       = azurerm_storage_container.stg.id
}

output "has_immutability_policy" {
  description = "Is there an Immutability Policy configured on this Storage Container?"
  value       = azurerm_storage_container.stg.has_immutability_policy
}

output "has_legal_hold" {
  description = "Is there a Legal Hold configured on this Storage Container?"
  value       = azurerm_storage_container.stg.has_legal_hold
}