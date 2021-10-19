output "namespaces" {
  description = "Service Bus namespaces map"
  value       = azurerm_servicebus_namespace.servicebus_namespace.id
}