## Cosmos DB MongoDB API

# Create database
resource "azurerm_cosmosdb_mongo_database" "database" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  throughput          = try(var.settings.throughput, null)

  # Note : throughput & autoscaling are conflicting properties
  dynamic "autoscale_settings" {
    for_each = try(var.settings.autoscale_settings, {})

    content {
      max_throughput = autoscale_settings.value.max_throughput
    }
  }
}

# Create collection
resource "azurerm_cosmosdb_mongo_collection" "collection" {
  for_each = var.settings.collections

  name                = each.value.name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  database_name       = azurerm_cosmosdb_mongo_database.database.name
  shard_key           = each.value.shard_key
  default_ttl_seconds = try(each.value.default_ttl_seconds, -1)
  throughput          = try(each.value.throughput, null)

  # Note : throughput & autoscaling are conflicting properties
  dynamic "autoscale_settings" {
    for_each = try(each.value.autoscale_settings, {})

    content {
      max_throughput = autoscale_settings.value.max_throughput
    }
  }

  dynamic "index" {
    for_each = try(each.value.index, {})

    content {
      keys = index.value.keys
      unique = try(index.value.unique, false)
    }
  }
}

