output "id" {
  value       = azurerm_communication_service.acs.id
  description = "The ID of the Communication Service."
}
output "primary_connection_string" {
  value       = azurerm_communication_service.acs.primary_connection_string
  description = "The primary connection string of the Communication Service."
}
output "secondary_connection_string" {
  value       = azurerm_communication_service.acs.secondary_connection_string
  description = "The secondary connection string of the Communication Service."
}
output "primary_key" {
  value       = azurerm_communication_service.acs.primary_key
  description = "The primary key of the Communication Service."
}
output "secondary_key" {
  value       = azurerm_communication_service.acs.secondary_key
  description = "The secondary key of the Communication Service."
}
