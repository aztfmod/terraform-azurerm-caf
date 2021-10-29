
module "subnets" {
  source = "../virtual_network/subnet"
  for_each = try(var.settings.subnets, {})

  name                                           = each.value.name
  global_settings                                = var.global_settings
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = var.virtual_network_name
  address_prefixes                               = try(each.value.cidr, [])
  service_endpoints                              = try(each.value.service_endpoints, [])
  enforce_private_link_endpoint_network_policies = try(each.value.enforce_private_link_endpoint_network_policies, false)
  enforce_private_link_service_network_policies  = try(each.value.enforce_private_link_service_network_policies, false)
  settings                                       = each.value

}

module "special_subnets" {
  source = "../virtual_network/subnet"
  for_each                                       = try(var.settings.special_subnets, {})
  
  name                                           = each.value.name
  global_settings                                = var.global_settings
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = var.virtual_network_name
  address_prefixes                               = try(each.value.cidr, [])
  service_endpoints                              = try(each.value.service_endpoints, [])
  enforce_private_link_endpoint_network_policies = try(each.value.enforce_private_link_endpoint_network_policies, false)
  enforce_private_link_service_network_policies  = try(each.value.enforce_private_link_service_network_policies, false)
  settings                                       = each.value
}

resource "azurerm_subnet_route_table_association" "rt" {
  for_each = {
    for key, subnet in merge(lookup(var.settings, "subnets", {}), lookup(var.settings, "specialsubnets", {})) : key => subnet
    if try(subnet.route_table_key, null) != null
  }

  subnet_id      = coalesce(lookup(module.subnets, each.key, null), lookup(module.special_subnets, each.key, null)).id
  route_table_id = var.route_tables[each.value.route_table_key].id
}

resource "azurerm_subnet_network_security_group_association" "nsg_vnet_association_version" {
  for_each = {
    for key, value in try(var.settings.subnets, {}) : key => value
    if try(var.network_security_group_definition[value.nsg_key].version, 0) > 0 && try(value.nsg_key, null) != null
  }

  subnet_id                 = module.subnets[each.key].id
  network_security_group_id = var.network_security_groups[each.value.nsg_key].id
}
