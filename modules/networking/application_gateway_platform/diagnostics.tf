module "diagnostics" {
  source = "../../diagnostics"

  resource_id       = azurerm_application_gateway.agw.id
  resource_location = local.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}