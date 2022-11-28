output "id" {
  value = azurerm_mssql_database.mssqldb.id
}

output "name" {
  value = azurerm_mssql_database.mssqldb.name
}

output "server_id" {
  value = azurerm_mssql_database.mssqldb.server_id
}

output "server_name" {
  value = var.server_name
}

output "server_fqdn" {
  value = local.server_name
}
