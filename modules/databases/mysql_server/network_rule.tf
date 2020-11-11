resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.7.30.0/29"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.7.30.0/29"]
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_mysql_virtual_network_rule" "mysql_network" {
  for_each = var.settings.mysql_network
  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql.name
  subnet_id           = azurerm_subnet.internal.id
}