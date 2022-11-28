
resource "azurerm_mariadb_database" "mariadb_database" {

  for_each = var.settings.mariadb_database

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mariadb_server.mariadb.name
  charset             = each.value.charset
  collation           = each.value.collation
}