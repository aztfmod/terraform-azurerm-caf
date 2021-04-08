## Cosmos DB Gremlin API

# Create database
resource "azurerm_cosmosdb_gremlin_database" "database" {
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

# Create graphs
module "gremlin_graphs" {
  source   = "./gremlin_graph"
  for_each = try(var.settings.graphs, {})

  global_settings       = var.global_settings
  settings              = each.value
  resource_group_name   = var.resource_group_name
  cosmosdb_account_name = var.cosmosdb_account_name
  gremlin_database_name = azurerm_cosmosdb_gremlin_database.database.name
}

output "gremlin_graphs" {
  value = module.gremlin_graphs

}

