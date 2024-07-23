output "id" {
  description = "The ID of the SignalR Service"
  value       = azurerm_signalr_service.signalr_service.id
}

output "name" {
  description = "The name of the SignalR Service"
  value       = azurerm_signalr_service.signalr_service.name
}

output "primary_connection_string" {
  description = "The primary connection string of the SignalR Service"
  value       = azurerm_signalr_service.signalr_service.primary_connection_string
}

output "secondary_connection_string" {
  description = "The secondary connection string of the SignalR Service"
  value       = azurerm_signalr_service.signalr_service.secondary_connection_string
}

output "resource_group_name" {
  description = "The resource group name of the SignalR Service"
  value       = local.resource_group_name
}
