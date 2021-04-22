module "gremlin_databases" {
  source   = "./gremlin_database"
  for_each = try(var.settings.gremlin_databases, {})

  global_settings       = var.global_settings
  settings              = each.value
  resource_group_name   = azurerm_cosmosdb_account.cosmos_account.resource_group_name
  location              = azurerm_cosmosdb_account.cosmos_account.location
  cosmosdb_account_name = azurerm_cosmosdb_account.cosmos_account.name
}

output "gremlin_databases" {
  value = module.gremlin_databases

}