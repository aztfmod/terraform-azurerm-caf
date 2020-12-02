
module nsg_flows {
  source = "./flow_logs"
  for_each = {
    for key, subnet in var.subnets : key => subnet
    if try(var.network_security_group_definition[subnet.nsg_key].flow_logs, null) != null
  }

  resource_id       = azurerm_network_security_group.nsg_obj[each.key].id
  resource_location = var.location
  diagnostics       = var.diagnostics
  settings          = var.network_security_group_definition[each.value.nsg_key].flow_logs
  network_watchers  = var.network_watchers
}
