module "mongo_databases" {
  source   = "./mongo_database"
  for_each = try(var.settings.mongo_databases, {})

  global_settings       = var.global_settings
  settings              = each.value
  resource_group_name   = azurerm_cosmosdb_account.cosmos_account.resource_group_name
  cosmosdb_account_name = azurerm_cosmosdb_account.cosmos_account.name
}

output "mongo_databases" {
  value = module.mongo_databases

}