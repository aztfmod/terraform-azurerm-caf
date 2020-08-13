module diagnostics {
  source = "/tf/caf/modules/diagnostics"

  # for_each = {
  #   for key in lookup(var.keyvault, "diagnostic_keys", []) : key => key
  # }

  resource_id       = azurerm_key_vault.keyvault.id
  resource_location = azurerm_key_vault.keyvault.location
  diagnostics       = var.diagnostics
  profiles          = var.keyvault.diagnostic_profiles
}