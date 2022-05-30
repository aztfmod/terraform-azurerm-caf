
module "diagnostics" {
  source = "../../diagnostics"
  count  = var.diagnostic_profiles == null ? 0 : 1

  resource_id       = azurerm_app_service_environment_v3.asev3.id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.diagnostic_profiles
}