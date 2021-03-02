resource "azurerm_netapp_account" "account" {
  # Must be unique for the subscription.
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  location            = var.location
}
