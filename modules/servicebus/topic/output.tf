output "id" {
  description = "The ID of the Service Bus topic"
  value       = azurerm_servicebus_topic.topic.id
}

output "name" {
  description = "The name of the Service Bus Topic"
  value       = azurerm_servicebus_topic.topic.name
}

output "topic_auth_rules" {
  description = "The topic auth rules associated with this topic"
  value       = module.topic_auth_rules
}