## Cosmos DB Table API

# Create database
resource "azurerm_cosmosdb_table" "table" {
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
