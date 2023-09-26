data "azurecaf_name" "powerbi" {
  name          = var.name
  resource_type = "azurerm_powerbi_embedded"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


resource "azurerm_powerbi_embedded" "powerbi" {
  name                = data.azurecaf_name.powerbi.result
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  administrators      = var.administrators
  mode                = try(var.mode, null)
  tags                = var.tags
}