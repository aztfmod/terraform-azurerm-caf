resource "azurerm_netapp_account" "account" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  location            = var.location
}
