output "id" {
  value       = azurerm_kusto_database.kusto.id
  description = "The ID of the Kusto Database."
}
output "name" {
  value       = azurerm_kusto_database.kusto.name
  description = "The name of the Kusto Database."
}
output "size" {
  value       = azurerm_kusto_database.kusto.size
  description = "The size of the database in bytes.."
}
