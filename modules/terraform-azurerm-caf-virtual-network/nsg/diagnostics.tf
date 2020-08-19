
module diagnostics {
  source   = "/tf/caf/modules/diagnostics"
  for_each = var.subnets

  resource_id       = azurerm_network_security_group.nsg_obj[each.key].id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = var.network_security_group_definition[each.value.nsg_key].diagnostic_profiles
}