module "diagnostics" {
  source = "../../diagnostics"
  count  = length(try(var.settings.diagnostic_profiles, {})) > 0 ? 1 : 0

  resource_id       = "${azurerm_mssql_server.mssql.id}/databases/master"
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}
