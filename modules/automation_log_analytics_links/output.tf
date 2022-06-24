output "id" {
  description = "The Automation Account ID."
  value       = azurerm_log_analytics_linked_service.linked_service.id
}

output "name" {
  description = "The Automation Account name."
  value       = azurerm_log_analytics_linked_service.linked_service.name
}

