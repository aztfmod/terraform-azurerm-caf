

# Configuration
resource "time_sleep" "wait_30_seconds" {
  depends_on = [azurerm_postgresql_server.postgresql]

  create_duration = "30s"
}

resource "azurerm_postgresql_configuration" "postgresql_configuration" {
  depends_on = [time_sleep.wait_30_seconds]
  for_each = var.settings.postgresql_configurations

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql.name
  value               = each.value.value
}
