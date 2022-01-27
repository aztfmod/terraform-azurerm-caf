module "diagnostics" {
  source   = "../../diagnostics"
  for_each = try(var.settings.diagnostic_profiles, {})

  resource_id       = azurerm_postgresql_flexible_server.postgresql.id
  resource_location = azurerm_postgresql_flexible_server.postgresql.location
  diagnostics       = var.remote_objects.diagnostics
  profiles          = var.settings.diagnostic_profiles
}