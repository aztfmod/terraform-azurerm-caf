## Cosmos DB SQL API

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create database
resource "azurerm_cosmosdb_sql_database" "database" {
  name                = format("%s-%s", var.settings.name, random_integer.ri.result)
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  throughput          = var.settings.throughput

  # Note : throughput & autoscaling is conflicting properties, Therefore, set any one of them
  dynamic "autoscale_settings" {
    for_each = lookup(var.settings, "autoscale_settings", {}) == {} ? [] : [1]

    content {
      max_throughput = try(autoscale_settings.value.max_throughput, {})
    }
  }
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

  default_ttl = try(each.value.default_ttl, -1)

  dynamic "unique_key" {
    for_each = lookup(var.settings, "unique_key", {}) == {} ? [] : [1]

    content {
      paths = try(unique_key.each.value.path, {})
    }
  }

  # Note : throughput & autoscaling is conflicting properties, Therefore, set any one of them
  dynamic "autoscale_settings" {
    for_each = lookup(var.settings, "autoscale_settings", {}) == {} ? [] : [1]

    content {
      max_throughput = try(autoscale_settings.value.max_throughput, {})
    }
  }

  dynamic "indexing_policy" {
    for_each = lookup(var.settings, "indexing_policy", {}) == {} ? [] : [1]

    content {
      indexing_mode = try(indexing_policy.value.indexing_mode, {})
      included_path {
        path = try(indexing_policy.value.included_path, {})
      }
      excluded_path {
        path = try(indexing_policy.value.excluded_path, {})
      }
      composite_index {
        index {
          path  = try(indexing_policy.value.path, {})
          order = try(indexing_policy.value.order, {})
        }
      }
    }
  }

}

