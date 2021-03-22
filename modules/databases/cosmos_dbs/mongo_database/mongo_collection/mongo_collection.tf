# Create collection
resource "azurerm_cosmosdb_mongo_collection" "collection" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  database_name       = var.database_name
  shard_key           = var.settings.shard_key
  default_ttl_seconds = try(var.settings.default_ttl_seconds, -1)
  throughput          = try(var.settings.throughput, null)

  # Note : throughput & autoscaling are conflicting properties
  dynamic "autoscale_settings" {
    for_each = try(var.settings.autoscale_settings, {})

    content {
      max_throughput = autoscale_settings.value.max_throughput
    }
  }

  dynamic "index" {
    for_each = try(var.settings.indexes, {})

    content {
      keys   = index.value.keys
      unique = try(index.value.unique, false)
    }
  }
}