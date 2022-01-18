output "id" {
  description = "The ID of the Auth rule id"
  value       = azurerm_servicebus_queue_authorization_rule.queue_auth_rule.id
}

output "name" {
  description = "The name of the Auth rule"
  value       = azurerm_servicebus_queue_authorization_rule.queue_auth_rule.name
}