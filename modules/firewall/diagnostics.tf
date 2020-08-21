module diagnostics {
  source = "../diagnostics"

  resource_id       = azurerm_firewall.fw.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}