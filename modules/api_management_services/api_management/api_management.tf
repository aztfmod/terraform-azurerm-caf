resource "azurecaf_name" "api_management" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_api_management_service"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_api_management" "example" {
  name                = azurecaf_name.api_management.result
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.settings.publisher_name
  publisher_email     = var.settings.publisher_email

  sku_name = var.settings.sku_name
}