## Cosmos DB SQL API

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create example Database
resource "azurerm_cosmosdb_sql_database" "ex_database" {
  name                = "${var.settings.name}-${random_integer.ri.result}"
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  throughput          = var.settings.throughput
}

# Create example Container
resource "azurerm_cosmosdb_sql_container" "ex_container" {
  name                = var.settings.container_re1.name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  database_name       = azurerm_cosmosdb_sql_database.ex_database.name
  partition_key_path  = var.settings.container_re1.partition_key_path
  throughput          = var.settings.container_re1.throughput

  unique_key {
    paths = var.settings.container_re1.unique_key_path
  }
}

