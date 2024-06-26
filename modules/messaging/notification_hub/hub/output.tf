output "id" {
  description = "The ID of the Notification Hub"
  value       = azurerm_notification_hub.hub.id
}

output "name" {
  description = "The Name of the Notification Hub"
  value       = azurerm_notification_hub.hub.name
}
