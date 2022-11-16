## Cosmos DB Gremlin API

# Create graphs
resource "azurerm_cosmosdb_gremlin_graph" "graph" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  database_name       = var.gremlin_database_name
  partition_key_path  = var.settings.partition_key_path

  # Note : throughput & autoscaling are conflicting properties
  dynamic "autoscale_settings" {
    for_each = try(var.settings.autoscale_settings, {})

    content {
      max_throughput = autoscale_settings.value.max_throughput
    }
  }

  dynamic "index_policy" {
    for_each = var.settings.index_policies

    content {
      automatic      = try(index_policy.value.automatic, true)
      indexing_mode  = index_policy.value.indexing_mode
      included_paths = try(index_policy.value.included_paths, [])
      excluded_paths = try(index_policy.value.excluded_paths, [])
    }
  }

  dynamic "conflict_resolution_policy" {
    for_each = var.settings.conflict_resolution_policies

    content {
      mode                     = conflict_resolution_policy.value.mode
      conflict_resolution_path = try(conflict_resolution_policy.value.conflict_resolution_path, "/_ts")
    }
  }

  dynamic "unique_key" {
    for_each = try(var.settings.unique_keys, {})

    content {
      paths = unique_key.value.paths
    }
  }
}

