provider "azurerm" {
  features {}
}

provider "azurecaf" {
  version = "1.2.0"
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_dev_center_dev_box_definition" "example" {
  name                = var.dev_box_definition_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

output "dev_box_definition_id" {
  value = azurerm_dev_center_dev_box_definition.example.id
}
