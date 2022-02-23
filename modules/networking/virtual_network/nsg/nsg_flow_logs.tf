
module "nsg_flows" {
  source = "./flow_logs"
  for_each = {
    for key, subnet in var.subnets : key => subnet
    if try(var.network_security_group_definition[subnet.nsg_key].flow_logs, null) != null && try(var.network_security_group_definition[subnet.nsg_key].version, 0) == 0
  }

  client_config     = var.client_config
  resource_id       = try(var.network_security_groups[each.value.nsg_key], null) == null ? azurerm_network_security_group.nsg_obj[each.key].id : var.network_security_groups[each.value.nsg_key].id
  resource_location = var.location
  diagnostics       = var.diagnostics
  settings          = var.network_security_group_definition[each.value.nsg_key].flow_logs
  network_watchers  = var.network_watchers
}
