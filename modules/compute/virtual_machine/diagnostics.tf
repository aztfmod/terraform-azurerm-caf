
module nics {
  source   = "../../diagnostics"
  for_each = var.settings.networking_interfaces

  resource_id       = azurerm_network_interface.nic[each.key].id
  resource_location = azurerm_network_interface.nic[each.key].location
  diagnostics       = var.diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}