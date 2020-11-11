## Cosmos DB SQL API

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create database
resource "azurerm_cosmosdb_sql_database" "database" {
  name                = "${var.settings.name}-${random_integer.ri.result}"
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  throughput          = var.settings.throughput
}

# Create container
resource "azurerm_cosmosdb_sql_container" "container" {
  for_each = var.settings.containers

  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  database_name       = azurerm_cosmosdb_sql_database.database.name
  partition_key_path  = each.value.partition_key_path
  throughput          = each.value.throughput

  unique_key {
    paths = each.value.unique_key_path
  }
}

