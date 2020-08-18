module diagnostics {
  source = "/tf/caf/modules/diagnostics"
  count = lookup(var.keyvault, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_key_vault.keyvault.id
  resource_location = azurerm_key_vault.keyvault.location
  diagnostics       = var.diagnostics
  profiles          = var.keyvault.diagnostic_profiles
}