output "topics" {
  description = "Service Bus topics map"
  value       = azurerm_servicebus_topic.topic
}

output "senders" {
  description = "Service Bus \"sender\" authorization rules map"
  value       = azurerm_servicebus_topic_authorization_rule.sender
}

output "readers" {
  description = "Service Bus \"readers\" authorization rules map"
  value       = azurerm_servicebus_topic_authorization_rule.reader
}

output "manages" {
  description = "Service Bus \"managers\" authorization rules map"
  value       = azurerm_servicebus_topic_authorization_rule.manage
}