output "id" {
  description = "The Log Analytics Workspace linked service id"
  value       = azurerm_log_analytics_linked_service.linked_service.id
}

output "name" {
  description = "The Log Analytics Workspace linked service name"
  value       = azurerm_log_analytics_linked_service.linked_service.name
}

