module "diagnostics" {
  source = "../../diagnostics"
  count  = var.diagnostic_profiles == {} ? 0 : 1

  resource_id       = azurerm_api_management.apim.id
  resource_location = azurerm_api_management.apim.location
  diagnostics       = var.diagnostics
  profiles          = try(var.diagnostic_profiles, {})
}
