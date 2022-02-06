

module "diagnostics" {
  source   = "../../diagnostics"
  for_each = try(var.settings.diagnostic_profiles, {})

  resource_id       = azurerm_mysql_flexible_server.mysql.id
  resource_location = azurerm_mysql_flexible_server.mysql.location
  diagnostics       = var.remote_objects.diagnostics
  profiles          = var.settings.diagnostic_profiles
}


