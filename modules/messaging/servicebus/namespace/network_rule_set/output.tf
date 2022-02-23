output "id" {
  description = "The ID of the Namespace network rule set"
  value       = azurerm_servicebus_namespace_network_rule_set.rule_set.id
}
