output "id" {
  description = "The Notification Hub ID."
  value       = azurerm_notification_hub.ntf.id
}

output "name" {
  description = "The Notification Hub name."
  value       = azurerm_notification_hub.ntf.name
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}

