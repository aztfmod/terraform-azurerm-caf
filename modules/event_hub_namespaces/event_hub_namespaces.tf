resource "azurecaf_name" "evh" {
  name          = var.settings.name
  resource_type = "azurerm_eventhub_namespace"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_eventhub_namespace" "evh" {
  name                = azurecaf_name.evh.result
  location            = var.global_settings.regions[var.settings.region]
  resource_group_name = var.resource_groups[var.settings.resource_group_key].name
  sku                 = var.settings.sku
  capacity            = try(var.settings.capacity, null)
  tags                = local.tags
}