output "id" {
  description = "The ID of the Service Bus Namespace"
  value       = azurerm_servicebus_namespace.namespace.id
}

output "name" {
  description = "The name of the Service Bus Namespace"
  value       = azurerm_servicebus_namespace.namespace.name
}

output "resource_group_name" {
  description = "The resource group name of the service bus namespace"
  value       = local.resource_group_name
}
