## Naming Convention
resource "azurecaf_name" "cdb" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
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
  kind                = try(var.settings.kind, "GlobalDocumentDB")
  tags                = local.tags

  enable_free_tier                  = try(var.settings.enable_free_tier, false)
  ip_range_filter                   = try(var.settings.ip_range_filter, null)
  enable_multiple_write_locations   = try(var.settings.enable_multiple_write_locations, false)
  enable_automatic_failover         = try(var.settings.enable_automatic_failover, null)
  is_virtual_network_filter_enabled = try(var.settings.is_virtual_network_filter_enabled, null)

  dynamic "consistency_policy" {
    for_each = lookup(var.settings, "consistency_policy", {}) == {} ? [] : [1]

    content {
      consistency_level       = var.settings.consistency_policy.consistency_level
      max_interval_in_seconds = try(var.settings.consistency_policy.max_interval_in_seconds, null)
      max_staleness_prefix    = try(var.settings.consistency_policy.max_staleness_prefix, null)
    }
  }

  # Primary location (Write Region)
  dynamic "geo_location" {
    for_each = var.settings.geo_locations

    content {
      location          = try(var.global_settings.regions[geo_location.value.region], geo_location.value.location)
      failover_priority = geo_location.value.failover_priority
      zone_redundant    = try(geo_location.value.zone_redundant, null)
    }
  }

  # Optional
  dynamic "capabilities" {
    for_each = try(toset(var.settings.capabilities), [])

    content {
      name = capabilities.value
    }
  }
}


