# Configuration
#

resource "azurerm_mariadb_configuration" "mariadb_configuration" {

  for_each = var.settings.mariadb_configuration

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mariadb_server.mariadb.name
  value               = each.value.value
}