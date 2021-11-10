resource "azurerm_network_profile" "netprof" {
  name                = var.settings.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  container_network_interface  {
    name = var.settings.container_network_interface.name

    ip_configuration {
      name      = var.settings.container_network_interface.ip_configuration.name
      subnet_id = var.settings.container_network_interface.ip_configuration.subnet_id
    }
  }
}