output "cosmos_account" {
  value = azurerm_cosmosdb_account.cosmos_account.id
}

output "connection_string" {
  value = azurerm_cosmosdb_account.cosmos_account.connection_strings[0]
}

output "primary_key" {
  value = azurerm_cosmosdb_account.cosmos_account.primary_key
}

output "endpoint" {
  value = azurerm_cosmosdb_account.cosmos_account.endpoint
}

output "name" {
  value = azurecaf_name.cdb.result
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}
