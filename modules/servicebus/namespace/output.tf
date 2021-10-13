output "id" {
  description = "The ID of the Service Bus Namespace"
  value       = azurerm_servicebus_namespace.namespace.id
}

output "name" {
  description = "The name of the Service Bus Namespace"
  value       = azurerm_servicebus_namespace.namespace.name
}
