provider "azurerm" {
  features {}
}

provider "azurecaf" {
  resource_type = "azurerm_resource_group"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_dev_center_network_connection" "example" {
  name                = "example-network-connection"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  domain_name         = "example.com"
  subnet_id           = "example-subnet-id"
  domain_password     = "example-password"
  domain_username     = "example-username"
  join_type           = "HybridAzureADJoin"
}

output "network_connection_id" {
  value = azurerm_dev_center_network_connection.example.id
}
