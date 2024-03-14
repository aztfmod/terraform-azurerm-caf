
resource "azurecaf_name" "service" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_search_service"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_search_service" "search_service" {
  name                                     = azurecaf_name.service.result
  location                                 = local.location
  resource_group_name                      = local.resource_group_name
  sku                                      = lower(var.settings.sku)
  local_authentication_enabled             = try(var.settings.local_authentication_enabled, null)
  authentication_failure_mode              = try(var.settings.authentication_failure_mode, null)
  public_network_access_enabled            = try(var.settings.public_network_access_enabled, false)
  allowed_ips                              = try(var.settings.public_network_access_enabled, false) ? try(var.settings.allowed_ips, []) : []
  customer_managed_key_enforcement_enabled = try(var.settings.customer_managed_key_enforcement_enabled, null)
  hosting_mode                             = (lower(var.settings.sku) == "standard3") ? try(var.settings.hosting_mode, "default") : null
  dynamic "identity" {
    for_each = try(var.identity, null) == null ? [] : [1]

    content {
      type = var.identity.type
    }
  }
  partition_count = ((lower(var.settings.sku) != "free") && (lower(var.settings.sku) != "basic")) ? try(var.settings.partition_count, null) : null
  replica_count   = (lower(var.settings.sku) != "free") ? try(var.settings.replica_count, null) : null
}