provider "azurerm" {
  features {}
}

resource "azurecaf_name" "dev_center_catalog_name" {
  name          = var.dev_center_catalog_name
  resource_type = "azurerm_dev_center_catalog"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_dev_center_catalog" "dev_center_catalog" {
  name                = azurecaf_name.dev_center_catalog_name.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  depends_on = [azurecaf_name.dev_center_catalog_name]
}
