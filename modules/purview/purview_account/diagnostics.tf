module "diagnostics_automation" {
  source = "../../diagnostics"

  resource_id       = azurerm_purview_account.pva.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}