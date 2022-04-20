module "diagnostics" {
  source = "../../../diagnostics"
  count  = var.diagnostic_profiles == null ? 0 : 1

  resource_id       = lookup(azurerm_eventgrid_domain.egd, "id")
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}