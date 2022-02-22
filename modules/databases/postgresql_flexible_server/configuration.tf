resource "time_sleep" "server_configuration" {
  depends_on = [azurerm_postgresql_flexible_server.postgresql]

  create_duration  = "120s"
  destroy_duration = "300s"
}

resource "azurerm_postgresql_flexible_server_configuration" "postgresql" {
  depends_on = [time_sleep.server_configuration]
  for_each   = try(var.settings.postgresql_configurations, {})

  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.postgresql.id
  value     = each.value.value
}