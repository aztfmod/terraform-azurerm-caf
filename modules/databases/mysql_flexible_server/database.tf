resource "time_sleep" "database_configuration" {
  depends_on = [azurerm_mysql_flexible_server.mysql]

  create_duration = "120s"
}


resource "azurerm_mysql_flexible_database" "mysql" {
  depends_on = [time_sleep.database_configuration]
  for_each   = try(var.settings.mysql_databases, {})

  name        = each.value.name
  server_name = azurerm_mysql_flexible_server.mysql.name
  collation   = try(each.value.collation, "utf8_unicode_ci")
  charset     = try(each.value.charset, "utf8")
  resource_group_name = var.resource_group.name
}

resource "azurerm_key_vault_secret" "mysql_database_name" {
  for_each = { for key, value in var.settings.mysql_databases : key => value if can(var.settings.keyvault) }

  name         = format("%s-ON-%s", azurerm_mysql_flexible_server.mysql.name, each.value.name )
  value        = each.value.name
  key_vault_id = var.remote_objects.keyvault_id
}
