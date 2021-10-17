module "diagnostics" {
  source = "../../diagnostics"
  count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_cdn_profile.profile.id
  resource_location = azurerm_cdn_profile.profile.location
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}