resource "azurerm_user_assigned_identity" "msi" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = format("%s-%s", var.prefix, var.name)
}

