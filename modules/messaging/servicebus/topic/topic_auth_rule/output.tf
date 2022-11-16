output "id" {
  description = "The ID of the Auth rule id"
  value       = azurerm_servicebus_topic_authorization_rule.topic_auth_rule.id
}

output "name" {
  description = "The name of the Auth rule"
  value       = azurerm_servicebus_topic_authorization_rule.topic_auth_rule.name
}

output "primary_connection_string" {
  description = "The Primary Connection String for the ServiceBus Namespace authorization Rule."
  value       = azurerm_servicebus_topic_authorization_rule.topic_auth_rule.primary_connection_string
}

output "secondary_connection_string" {
  description = "The Secondary Connection String for the ServiceBus Namespace authorization Rule."
  value       = azurerm_servicebus_topic_authorization_rule.topic_auth_rule.secondary_connection_string
}


