## Naming Convention
resource "azurecaf_name" "cdb" {
  name          = var.settings.name
  prefixes      = [var.global_settings.prefix]
  resource_type = "azurerm_cosmosdb_account"
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

  dynamic "consistency_policy" {
    for_each = lookup(var.settings, "consistency_policy", {}) == {} ? [] : [1]

    content {
      consistency_level       = var.settings.consistency_policy.consistency_level
      max_interval_in_seconds = try(var.settings.consistency_policy.max_interval_in_seconds, null)
      max_staleness_prefix    = try(var.settings.consistency_policy.max_staleness_prefix, null)
    }
  }

  # Primary location (Write Region)
  geo_location {
    prefix            = try(var.settings.primary_geo_location.prefix, null) == null ? null : "${azurecaf_name.cdb.result}-${var.settings.primary_geo_location.prefix}" # used to generate document endpoint
    location          = try(var.settings.primary_geo_location.region, var.location)
    failover_priority = 0
    zone_redundant    = try(var.settings.primary_geo_location.zone_redundant, false)
  }

  # failover location
  geo_location {
    location          = var.settings.failover_geo_location.region
    failover_priority = var.settings.failover_geo_location.failover_priority
  }

  # Optional 
  dynamic "capabilities" {
    for_each = lookup(var.settings, "capabilities", {}) == {} ? [] : [1]

    content {
      name = var.settings.capabilities
    }
  }

  /*  capabilities {
    name = try(var.settings.capabilities, {})
  } */
  enable_free_tier                = try(var.settings.enable_free_tier, {})
  ip_range_filter                 = try(var.settings.ip_range_filter, {})
  enable_multiple_write_locations = try(var.settings.enable_multiple_write_locations, false)

}


