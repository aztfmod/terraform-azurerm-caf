
#
# Firewall Rule
#

resource "azurerm_mysql_database" "mysql_database" {

  for_each = var.settings.mysql_databases

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql.name
  charset             = each.value.charset
  collation           = each.value.collation
}
