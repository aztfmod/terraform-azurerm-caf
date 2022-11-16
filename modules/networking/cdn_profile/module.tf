resource "azurecaf_name" "cdn" {
  name          = var.settings.name
  resource_type = "azurerm_cdn_profile"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_cdn_profile" "cdn" {
  name = azurecaf_name.cdn.result

  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.settings.sku
  tags                = local.tags

}
