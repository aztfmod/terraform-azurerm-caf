## Cosmos DB MongoDB API

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create example Database
resource "azurerm_cosmosdb_mongo_database" "ex_database" {
  name                = "${var.settings.database_re1.name}-${random_integer.ri.result}"
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  throughput          = var.settings.throughput
}

# Create example Container
resource "azurerm_cosmosdb_mongo_collection" "ex_collection" {
  name                = var.settings.collection_re1.name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  database_name       = azurerm_cosmosdb_mongo_database.ex_database.name
  shard_key           = var.settings.collection_re1.shard_key
  throughput          = var.settings.collection_re1.throughput
  default_ttl_seconds = var.settings.collection_re1.default_ttl_seconds
}

