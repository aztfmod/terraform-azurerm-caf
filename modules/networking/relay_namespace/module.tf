
resource "azurecaf_name" "rns" {
  name          = var.settings.name
  resource_type = "azurerm_relay_namespace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_relay_namespace" "rns" {
  name                = azurecaf_name.rns.result
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.settings.sku_name
  tags                = local.tags
}