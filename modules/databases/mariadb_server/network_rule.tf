resource "azurerm_mariadb_virtual_network_rule" "mariadb_vnet_rules" {
  for_each            = try(var.settings.mariadb_vnet_rules, {})
  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mariadb_server.mariadb.name
  subnet_id           = var.subnet_id
}