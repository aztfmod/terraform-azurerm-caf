module "diagnostics" {
  source = "../../diagnostics"
  count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_frontdoor.frontdoor.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}
