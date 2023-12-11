resource "azurecaf_name" "search" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "general_safe"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_search_service" "search" {
  name                = azurecaf_name.search.result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.settings.sku // basic, free, standard, standard2, standard3, storage_optimized_l1 and storage_optimized_l2

  replica_count       = try(var.settings.replica_count, null)
  partition_count     = try(var.settings.partition_count, null)

  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)

  dynamic "timeouts" {
    for_each = try(var.settings.timeouts, null) != null ? [var.settings.timeouts] : []
    content {
      create = try(timeouts.value.create, null)
      read   = try(timeouts.value.read, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }

  tags = try(var.settings.tags, {})
}
