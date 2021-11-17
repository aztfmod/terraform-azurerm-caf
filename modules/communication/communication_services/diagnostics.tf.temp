module "diagnostics" {
  source = "../diagnostics"
  count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_communication_service.acs.id
  resource_location = azurerm_communication_service.acs.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}