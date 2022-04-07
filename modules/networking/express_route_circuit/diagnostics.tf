
module "diagnostics" {
  source = "../../diagnostics"
  count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_express_route_circuit.circuit.id
  resource_location = azurerm_express_route_circuit.circuit.location
  diagnostics       = var.diagnostics
  profiles          = var.settings.diagnostic_profiles
}