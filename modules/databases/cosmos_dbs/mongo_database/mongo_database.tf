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

# Iterate through collections using sub-module
module "mongo_collections" {
  source   = "./mongo_collection"
  for_each = try(var.settings.collections, {})

  global_settings       = var.global_settings
  settings              = each.value
  resource_group_name   = var.resource_group_name
  cosmosdb_account_name = var.cosmosdb_account_name
  database_name         = azurerm_cosmosdb_mongo_database.database.name
}

output "mongo_collections" {
  value = module.mongo_collections

}