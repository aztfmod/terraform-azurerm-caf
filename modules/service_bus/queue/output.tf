output "queues" {
  description = "Service Bus queues map"
  value       = azurerm_servicebus_queue.queue
}

output "senders" {
  description = "Service Bus \"sender\" authorization rules map"
  value       = azurerm_servicebus_queue_authorization_rule.sender
}

output "readers" {
  description = "Service Bus \"readers\" authorization rules map"
  value       = azurerm_servicebus_queue_authorization_rule.reader
}

output "manages" {
  description = "Service Bus \"managers\" authorization rules map"
  value       = azurerm_servicebus_queue_authorization_rule.manage
}