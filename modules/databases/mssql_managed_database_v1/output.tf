
output "name" {
  value       = azurerm_mssql_managed_database.sqlmanageddatabase.name
  description = "SQL Managed DB Name"
}

output "id" {
  value       = azurerm_mssql_managed_database.sqlmanageddatabase.id
  description = "SQL Managed DB Id"
}
