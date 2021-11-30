output "id" {
  value       = azurerm_active_directory_domain_service.adds.id
  description = "The ID of the Domain Service."
}
output "deployment_id" {
  value       = azurerm_active_directory_domain_service.adds.deployment_id
  description = "A unique ID for the managed domain deployment."
}
output "resource_id" {
  value       = azurerm_active_directory_domain_service.adds.resource_id
  description = "The Azure resource ID for the domain service."
}
