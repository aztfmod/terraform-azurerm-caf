output "id" {
  description = "The ID of the Namespace Auth rule id"
  value       = azurerm_servicebus_namespace_authorization_rule.namespace_auth_rule.id
}

output "name" {
  description = "The name of the Namespace Auth rule"
  value       = azurerm_servicebus_namespace_authorization_rule.namespace_auth_rule.name
}