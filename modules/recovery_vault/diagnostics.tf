
module diagnostics {
  source = "../diagnostics"

  resource_id       = azurerm_recovery_services_vault.asr_rg_vault.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}