
module diagnostics {
  source = "../../diagnostics"
  for_each = {
    for key, subnet in var.subnets : key => subnet
    if lookup(subnet, "nsg_key", null) != null
  }

  resource_id       = azurerm_network_security_group.nsg_obj[each.key].id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = lookup(var.network_security_group_definition[each.value.nsg_key], "diagnostic_profiles", {})
}