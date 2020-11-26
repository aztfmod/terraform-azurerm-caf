
#
# Database
#

resource "azurerm_postgresql_database" "postgresql_database" {
  for_each = var.settings.postgresql_databases

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = each.value.charset
  collation           = each.value.collation
}
