module "sql_databases" {
  source   = "./sql_database"
  for_each = try(var.settings.sql_databases, {})

  global_settings       = var.global_settings
  settings              = each.value
  resource_group_name   = azurerm_cosmosdb_account.cosmos_account.resource_group_name
  location              = azurerm_cosmosdb_account.cosmos_account.location
  cosmosdb_account_name = azurerm_cosmosdb_account.cosmos_account.name
}

output "sql_databases" {
  value = module.sql_databases

}