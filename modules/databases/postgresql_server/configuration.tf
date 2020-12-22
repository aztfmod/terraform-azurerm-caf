

# Configuration


resource "azurerm_postgresql_configuration" "postgresql_configuration" {

  for_each = var.settings.postgresql_configurations

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql.name
  value               = each.value.value
}
