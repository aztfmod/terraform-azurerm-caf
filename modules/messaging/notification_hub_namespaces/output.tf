output "id" {
  description = "The EventHub Namespace ID."
  value       = azurerm_notification_hub_namespace.ntfns.id
}

output "servicebus_endpoint" {
  description = "The ServiceBus Endpoint for Notification Hub Namespace."
  value       = azurerm_notification_hub_namespace.ntfns.servicebus_endpoint
}

output "name" {
  description = "The Notification Hub Namespace name."
  value       = azurerm_notification_hub_namespace.ntfns.name
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}

