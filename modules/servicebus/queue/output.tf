output "id" {
  description = "The ID of the Service Bus queue"
  value       = azurerm_servicebus_queue.queue.id
}

output "name" {
  description = "The name of the Service Bus queue"
  value       = azurerm_servicebus_queue.queue.name
}

output "queue_auth_rules" {
  description = "The queue auth rules associated with this queue"
  value       = module.queue_auth_rules
}