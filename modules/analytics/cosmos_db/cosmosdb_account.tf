## Naming Convention
resource "azurecaf_name" "cdb" {
  name          = var.settings.name
  prefixes      = [var.global_settings.prefix]
  resource_type = "azurerm_machine_learning_workspace"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}
## Cosmos DB account
resource "azurerm_cosmosdb_account" "cosmos_account" {
  name                = azurecaf_name.cdb.result
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = var.settings.offer_type
  kind                = var.settings.kind

  enable_automatic_failover = var.settings.enable_automatic_failover

  consistency_policy {
    consistency_level       = var.settings.consistency_policy.consistency_level
    max_interval_in_seconds = var.settings.consistency_policy.max_interval_in_seconds
    max_staleness_prefix    = var.settings.consistency_policy.max_staleness_prefix
  }

  # Primary location (Write Region)
  geo_location {
    prefix            = "${azurecaf_name.cdb.result}-${var.settings.primary_geo_location.prefix}" # used to generate document endpoint
    location          = try(var.settings.primary_geo_location.location, var.location)
    failover_priority = var.settings.primary_geo_location.failover_priority
  }

  # failover location
  geo_location {
    location          = try(var.settings.failover_geo_location.location, var.location)
    failover_priority = var.settings.failover_geo_location.failover_priority
  }
}


