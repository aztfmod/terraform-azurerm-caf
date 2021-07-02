output "name" {
  description = "The name of the Storage Queue."
  value       = azurerm_storage_queue.queue.name
}

output "id" {
  description = "The ID of the Storage Queue."
  value       = azurerm_storage_queue.queue.id
}