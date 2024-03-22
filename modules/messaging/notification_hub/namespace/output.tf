output "id" {
  description = "The ID of the Notification Hub Namespace"
  value       = azurerm_notification_hub_namespace.notification_hub_namespace.id
}

output "name" {
  description = "The Name of the Notification Hub Namespace"
  value       = azurerm_notification_hub_namespace.notification_hub_namespace.name
}

output "servicebus_endpoint" {
  description = "The Service Bus endpoint for the Notification Hub Namespace"
  value       = azurerm_notification_hub_namespace.notification_hub_namespace.servicebus_endpoint
}
