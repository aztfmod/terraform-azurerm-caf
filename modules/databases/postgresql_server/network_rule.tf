resource "azurerm_postgresql_virtual_network_rule" "postgresql_vnet_rules" {
  for_each            = try(var.settings.postgresql_vnet_rules, {})
  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql.name
  subnet_id           = var.subnet_id
}