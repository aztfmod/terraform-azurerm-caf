
module diagnostics {
  source = "../diagnostics"
  count  = lookup(var.networking_object, "diagnostic_profiles", null) == null ? 0 : 1

  resource_id       = azurerm_virtual_network.vnet.id
  resource_location = azurerm_virtual_network.vnet.location
  diagnostics       = var.diagnostics
  profiles          = var.networking_object.diagnostic_profiles
}