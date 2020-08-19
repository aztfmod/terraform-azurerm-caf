
module diagnostics {
  source = "/tf/caf/modules/diagnostics"

  resource_id       = azurerm_virtual_network.vnet.id
  resource_location = azurerm_virtual_network.vnet.location
  diagnostics       = var.diagnostics
  profiles          = var.networking_object.diagnostic_profiles
}