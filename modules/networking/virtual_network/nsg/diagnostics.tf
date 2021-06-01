
module "diagnostics" {
  source = "../../../diagnostics"
  for_each = {
    for key, subnet in var.subnets : key => subnet
    if try(var.network_security_group_definition[subnet.nsg_key].diagnostic_profiles, null) != null && try(var.network_security_group_definition[subnet.nsg_key].version, 0) == 0
  }

  resource_id       = try(var.network_security_groups[each.value.nsg_key], null) == null ? azurerm_network_security_group.nsg_obj[each.key].id : var.network_security_groups[each.value.nsg_key].id
  resource_location = var.location
  diagnostics       = var.diagnostics
  profiles          = try(var.network_security_group_definition[each.value.nsg_key].diagnostic_profiles, var.network_security_group_definition["empty_nsg"].diagnostic_profiles)
}