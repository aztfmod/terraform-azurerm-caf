resource "azurerm_search_service" "search" {
  location                      = var.location
  name                          = var.settings.name
  public_network_access_enabled = var.public_network_access_enabled
  resource_group_name           = var.resource_group_name
  sku                           = var.settings.sku
  tags                          = local.tags
}
