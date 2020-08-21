module azurerm_firewall_diagnostics {
  source = "../diagnostics"
  for_each = {
    for key, value in try(var.settings.diagnostic_profiles, {}) : key => value
  }

  resource_id       = azurerm_firewall.fw.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}