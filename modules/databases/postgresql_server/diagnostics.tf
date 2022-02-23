
module "diagnostics" {
  source = "../../diagnostics"
  count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_postgresql_server.postgresql.id
  resource_location = azurerm_postgresql_server.postgresql.location
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}