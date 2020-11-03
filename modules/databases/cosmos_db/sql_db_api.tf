module sql_db_api {
  source   = "./sql_db_api"
  for_each = try(var.settings.sql_db, {})

  global_settings       = var.global_settings
  settings              = each.value
  resource_group_name   = azurerm_cosmosdb_account.cosmos_account.resource_group_name
  location              = azurerm_cosmosdb_account.cosmos_account.location
  cosmosdb_account_name = azurerm_cosmosdb_account.cosmos_account.name
}