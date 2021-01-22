output cosmos_account {
  value     = azurerm_cosmosdb_account.cosmos_account.id
  sensitive = true
}

output connection_string {
  value     = azurerm_cosmosdb_account.cosmos_account.connection_strings[0]
  sensitive = true
}