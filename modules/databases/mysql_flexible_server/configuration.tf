resource "time_sleep" "server_configuration" {
  depends_on = [azurerm_mysql_flexible_server.mysql]

  create_duration  = "120s"
  destroy_duration = "300s"
}

resource "azurerm_mysql_flexible_server_configuration" "mysql" {
  depends_on = [time_sleep.server_configuration]
  for_each   = try(var.settings.mysql_configurations, {})

  name                = each.value.name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  value               = each.value.value
  resource_group_name = var.resource_group_name
}
