
# azure_caf
resource "azurecaf_name" "namespace" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_namespace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_namespace" "namespace" {
  name                = azurecaf_name.namespace.result
  sku                 = var.settings.sku
  capacity            = try(var.settings.capacity, null)
  zone_redundant      = try(var.settings.zone_redundant, null)
  tags                = merge(local.base_tags, try(var.settings.tags, {}))
  location            = local.location
  resource_group_name = local.resource_group_name
}
