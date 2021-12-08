output "id" {
  description = "The ID of the Auth rule id"
  value       = azurerm_servicebus_topic_authorization_rule.topic_auth_rule.id
}

output "name" {
  description = "The name of the Auth rule"
  value       = azurerm_servicebus_topic_authorization_rule.topic_auth_rule.name
}