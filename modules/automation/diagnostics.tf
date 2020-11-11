module "diagnostics_automation" {
  source = "../diagnostics"

  resource_id       = azurerm_automation_account.auto_account.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}