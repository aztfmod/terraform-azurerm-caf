output "cosmos_account" {
  value = azurerm_cosmosdb_account.cosmos_account.id
}

output "primary_key" {
  value = azurerm_cosmosdb_account.cosmos_account.primary_key
}

output "primary_sql_connection_string" {
  value = azurerm_cosmosdb_account.cosmos_account.primary_sql_connection_string
}

output "secondary_sql_connection_string" {
  value = azurerm_cosmosdb_account.cosmos_account.secondary_sql_connection_string
}

output "primary_readonly_sql_connection_string" {
  value = azurerm_cosmosdb_account.cosmos_account.primary_readonly_sql_connection_string
}

output "secondary_readonly_sql_connection_string" {
  value = azurerm_cosmosdb_account.cosmos_account.secondary_readonly_sql_connection_string
}

output "primary_mongodb_connection_string" {
  value = azurerm_cosmosdb_account.cosmos_account.primary_mongodb_connection_string
}

output "secondary_mongodb_connection_string" {
  value = azurerm_cosmosdb_account.cosmos_account.secondary_mongodb_connection_string
}

output "primary_readonly_mongodb_connection_string" {
  value = azurerm_cosmosdb_account.cosmos_account.primary_readonly_mongodb_connection_string
}

output "secondary_readonly_mongodb_connection_string" {
  value = azurerm_cosmosdb_account.cosmos_account.secondary_readonly_mongodb_connection_string
}

output "endpoint" {
  value = azurerm_cosmosdb_account.cosmos_account.endpoint
}

output "name" {
  value = azurecaf_name.cdb.result
}

output "resource_group_name" {
  value = local.resource_group_name
}

output "location" {
  value = local.location
}

output "id" {
  value = azurerm_cosmosdb_account.cosmos_account.id
}
