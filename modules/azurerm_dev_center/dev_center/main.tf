provider "azurerm" {
  features {}
}

resource "azurecaf_name" "dev_center_name" {
  name          = var.dev_center_name
  resource_type = "azurerm_dev_center"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_dev_center" "dev_center" {
  name                = azurecaf_name.dev_center_name.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  depends_on = [azurecaf_name.dev_center_name]
}
