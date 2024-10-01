provider "azurerm" {
  features {}
}

resource "azurecaf_name" "network_connection_name" {
  name          = var.network_connection_name
  resource_type = "azurerm_dev_center_network_connection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_dev_center_network_connection" "network_connection" {
  name                = azurecaf_name.network_connection_name.result
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  domain_name         = var.domain_name
  domain_username     = var.domain_username
  domain_password     = var.domain_password
  tags                = var.tags

  depends_on = [azurecaf_name.network_connection_name]
}
