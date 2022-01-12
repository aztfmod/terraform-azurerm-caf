output "id" {
  description = "The ID of the Auth rule id"
  value       = azurerm_servicebus_subscription.subscription.id
}

output "name" {
  description = "The name of the Auth rule"
  value       = azurerm_servicebus_subscription.subscription.name
}

output "correlation_filter_rules" {
  value = module.correlation_filter_rules
}
output "sql_filter_rules" {
  value = module.sql_filter_rules
}
