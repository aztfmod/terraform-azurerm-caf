
module "diagnostics" {
  source = "../../diagnostics"
  count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_frontdoor.frontdoor.id
  # blinQ: Updated resource location to global_settings.default_region as Azure Frontdoor is a global service and the azurerm object don't provide an argument for location. Also, caf frontdoor module is implemented with support for resource_group_name as reference (resource_group key not required), this make it "impossible" to grab the location by code from the correct resource_group with 100% certenty (rg only store the metadata anyway)
  # resource_location = azurerm_frontdoor.frontdoor.location
  resource_location = var.global_settings.default_region
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}