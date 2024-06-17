output "cosmos_account" {
  value = azurerm_cosmosdb_account.cosmos_account.id
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
  value = local.resource_group_name
}

output "location" {
  value = local.location
}

output "id" {
  value = azurerm_cosmosdb_account.cosmos_account.id
}
