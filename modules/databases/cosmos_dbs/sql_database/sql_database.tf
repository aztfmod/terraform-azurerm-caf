## Cosmos DB SQL API

resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Create database
resource "azurerm_cosmosdb_sql_database" "database" {
  name                = try(var.settings.add_rnd_num, true) == false ? var.settings.name : format("%s-%s", var.settings.name, random_integer.ri.result)
  resource_group_name = var.resource_group_name
  account_name        = var.cosmosdb_account_name
  # Note : throughput and autoscale_settings conflict and autoscale_settings will take precedence if set
  throughput = try(var.settings.autoscale_settings, null) != null ? null : var.settings.throughput

  # Note : throughput and autoscale_settings conflict and autoscale_settings will take precedence if set
  dynamic "autoscale_settings" {
    for_each = try(var.settings.autoscale_settings, null) != null ? [var.settings.autoscale_settings] : []

    content {
      max_throughput = autoscale_settings.value.max_throughput
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
  # Note : throughput and autoscale_settings conflict and autoscale_settings will take precedence if set
  throughput  = try(each.value.autoscale_settings, null) != null ? null : each.value.throughput
  default_ttl = try(each.value.default_ttl, -1)

  dynamic "unique_key" {
    for_each = try(each.value.unique_key, null) != null ? [each.value.unique_key] : []

    content {
      paths = unique_key.value.paths
    }
  }

  # Note : throughput and autoscale_settings conflict and autoscale_settings will take precedence if set
  dynamic "autoscale_settings" {
    for_each = try(each.value.autoscale_settings, null) != null ? [each.value.autoscale_settings] : []

    content {
      max_throughput = autoscale_settings.value.max_throughput
    }
  }

  dynamic "indexing_policy" {
    for_each = try(each.value.indexing_policy, null) != null ? [each.value.indexing_policy] : []

    content {
      indexing_mode = try(indexing_policy.value.indexing_mode, null)

      dynamic "included_path" {
        for_each = try(indexing_policy.value.included_paths, {})

        content {
          path = included_path.value
        }
      }

      dynamic "excluded_path" {
        for_each = try(indexing_policy.value.excluded_paths, {})

        content {
          path = excluded_path.value
        }
      }

      dynamic "spatial_index" {
        for_each = try(indexing_policy.value.spatial_indexes, {})

        content {
          path = spatial_index.value
        }
      }

      dynamic "composite_index" {
        for_each = try(indexing_policy.value.composite_indexes, {})

        content {
          dynamic "index" {
            for_each = composite_index.value

            content {
              path  = index.value.path
              order = index.value.order
            }
          }
        }
      }
    }
  }

}
