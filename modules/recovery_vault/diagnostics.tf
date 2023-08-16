
module "diagnostics" {
  source = "../diagnostics"

  resource_id       = azurerm_recovery_services_vault.asr.id
  resource_location = local.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}