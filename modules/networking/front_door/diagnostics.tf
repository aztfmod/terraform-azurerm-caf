

module "diagnostics" {
  source = "../../diagnostics"
  count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_frontdoor.frontdoor.id
  resource_location = var.global_settings.default_region
  # resource_location = azurerm_frontdoor.frontdoor.location       // blinQ: Argument not supported for frontdore. Frontdoor is a global service so it makes sense to use the default_region for diagnostic logging.
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}