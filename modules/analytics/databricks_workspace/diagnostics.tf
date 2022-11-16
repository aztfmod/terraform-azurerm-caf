module "diagnostics" {
  source = "../../diagnostics"

  resource_id       = azurerm_databricks_workspace.ws.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}