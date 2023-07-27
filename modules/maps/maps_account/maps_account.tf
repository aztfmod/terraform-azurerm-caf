# naming convention
resource "azurecaf_name" "map" {
  name          = var.settings.name
  resource_type = "azurerm_maps_account"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_maps_account" "map" {
  name                = azurecaf_name.map.result
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
}
