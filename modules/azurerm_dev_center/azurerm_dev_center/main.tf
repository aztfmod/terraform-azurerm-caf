provider "azurecaf" {
  resource_type = "azurerm_resource_group"
}

resource "azurerm_dev_center" "example" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}
