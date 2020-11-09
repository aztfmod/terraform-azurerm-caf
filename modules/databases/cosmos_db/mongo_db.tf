module mongo_db {
  source   = "./mongo_db"
  for_each = try(var.settings.mongo_db, {})

  global_settings       = var.global_settings
  settings              = each.value
  resource_group_name   = azurerm_cosmosdb_account.cosmos_account.resource_group_name
  location              = azurerm_cosmosdb_account.cosmos_account.location
  cosmosdb_account_name = azurerm_cosmosdb_account.cosmos_account.name
}

output mongo_db = {
  value = module.mongo_db
  sensitive = true
}