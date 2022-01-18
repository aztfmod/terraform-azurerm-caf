output "id" {
  description = "The ID of the SignalR Service"
  value       = azurerm_signalr_service.signalr_service.id
}

output "name" {
  description = "The name of the SignalR Service"
  value       = azurerm_signalr_service.signalr_service.name
}

output "resource_group_name" {
  description = "The resource group name of the SignalR Service"
  value       = local.resource_group_name
}
