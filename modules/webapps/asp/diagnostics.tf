module "diagnostics" {
  source = "../../diagnostics"
  # count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_app_service_plan.asp.id
  resource_location = azurerm_app_service_plan.asp.location
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}
