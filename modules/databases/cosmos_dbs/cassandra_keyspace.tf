module "cassandra_keyspaces" {
  source   = "./cassandra_keyspace"
  for_each = try(var.settings.cassandra_keyspaces, {})

  global_settings       = var.global_settings
  settings              = each.value
  resource_group_name   = azurerm_cosmosdb_account.cosmos_account.resource_group_name
  location              = azurerm_cosmosdb_account.cosmos_account.location
  cosmosdb_account_name = azurerm_cosmosdb_account.cosmos_account.name
}

output "cassandra_keyspaces" {
  value = module.cassandra_keyspaces

}