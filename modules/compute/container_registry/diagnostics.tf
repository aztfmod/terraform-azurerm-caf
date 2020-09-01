module diagnostics {
  source = "../../diagnostics"

  resource_id       = azurerm_container_registry.acr.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}