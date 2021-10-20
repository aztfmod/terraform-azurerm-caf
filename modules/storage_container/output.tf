output "id" {
  value       = azurerm_storage_container.sc.id
  description = "The ID of the Storage Container."
}
output "has_immutability_policy" {
  value       = azurerm_storage_container.sc.has_immutability_policy
  description = "Is there an Immutability Policy configured on this Storage Container?"
}
output "has_legal_hold" {
  value       = azurerm_storage_container.sc.has_legal_hold
  description = "Is there a Legal Hold configured on this Storage Container?"
}
output "resource_manager_id" {
  value       = azurerm_storage_container.sc.resource_manager_id
  description = "The Resource Manager ID of this Storage Container."
}
