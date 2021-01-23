
resource "azurerm_mysql_virtual_network_rule" "mysql_vnet_rules" {
  for_each            = try(var.settings.mysql_vnet_rules, {})
  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql.name
  subnet_id           = var.subnet_id
}

