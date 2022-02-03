output "id" {
  value       = azurerm_kusto_database_principal_assignment.kusto.id
  description = "The ID of the Dedicated Host."
}
output "principal_name" {
  value       = azurerm_kusto_database_principal_assignment.kusto.principal_name
  description = "The name of the principal."
}
output "tenant_name" {
  value       = azurerm_kusto_database_principal_assignment.kusto.tenant_name
  description = "The name of the tenant."
}
