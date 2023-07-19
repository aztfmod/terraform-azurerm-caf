module "diagnostics" {
  source = "../../diagnostics"
  count  = length(try(var.settings.diagnostic_profiles, {})) > 0 ? 1 : 0

  resource_id       = azurerm_application_gateway.agw.id
  resource_location = local.location
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, {})
}
