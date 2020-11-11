## Cosmos DB MongoDB API

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create database
resource "azurerm_cosmosdb_mongo_database" "database" {
  name                = "${var.settings.name}-${random_integer.ri.result}"
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  throughput          = try(var.settings.throughput, null)
}

# Create collection
resource "azurerm_cosmosdb_mongo_collection" "collection" {
  for_each = var.settings.collections

  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  database_name       = azurerm_cosmosdb_mongo_database.database.name
  shard_key           = each.value.shard_key
  throughput          = try(each.value.throughput, null)
  default_ttl_seconds = each.value.default_ttl_seconds
}

