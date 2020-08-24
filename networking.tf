# 1 - virtual networks
# 2


output vnets {
  depends_on = [azurerm_virtual_network_peering.peering]
  value      = module.networking
  sensitive  = true
}

module "networking" {
  source = "./modules/terraform-azurerm-caf-virtual-network"

  for_each = var.networking.vnets

  max_length                        = local.global_settings.max_length
  prefix                            = local.global_settings.prefix
  convention                        = try(each.value.convention, local.global_settings.convention)
  location                          = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name               = azurerm_resource_group.rg[each.value.resource_group_key].name
  settings                          = each.value
  network_security_group_definition = local.networking.network_security_group_definition
  route_tables                      = module.route_tables
  tags                              = try(each.value.tags, null)
  diagnostics                       = local.diagnostics
}


module public_ip_addresses {
  source = "./modules/networking/public_ip_addresses"

  for_each = local.networking.public_ip_addresses

  name                    = each.value.name
  resource_group_name     = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  sku                     = try(each.value.sku, "Basic")
  allocation_method       = try(each.value.allocation_method, "Dynamic")
  ip_version              = try(each.value.ip_version, "IPv4")
  idle_timeout_in_minutes = try(each.value.idle_timeout_in_minutes, null)
  domain_name_label       = try(each.value.domain_name_label, null)
  reverse_fqdn            = try(each.value.reverse_fqdn, null)
  tags                    = try(each.value.tags, null)
  zones                   = try(each.value.zones, null)
  diagnostic_profiles     = try(each.value.diagnostic_profiles, {})
  diagnostics             = local.diagnostics
}

resource "azurerm_virtual_network_peering" "peering" {
  depends_on = [module.networking]
  for_each   = local.networking.vnet_peerings

  name                         = each.value.name
  virtual_network_name         = module.networking[each.value.from_key].name
  resource_group_name          = module.networking[each.value.from_key].resource_group_name
  remote_virtual_network_id    = module.networking[each.value.to_key].id
  allow_virtual_network_access = lookup(each.value, "allow_virtual_network_access", true)
  allow_forwarded_traffic      = lookup(each.value, "allow_forwarded_traffic", false)
  allow_gateway_transit        = lookup(each.value, "allow_gateway_transit", false)
  use_remote_gateways          = lookup(each.value, "use_remote_gateways", false)
}

module "route_tables" {
  source   = "./modules/networking/route_tables"
  for_each = local.networking.route_tables

  name                          = each.value.name
  resource_group_name           = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                      = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  disable_bgp_route_propagation = try(each.value.disable_bgp_route_propagation, null)
  tags                          = try(each.value.tags, null)
}

module "routes" {
  source   = "./modules/networking/routes"
  for_each = local.networking.azurerm_routes

  name                      = each.value.name
  resource_group_name       = azurerm_resource_group.rg[each.value.resource_group_key].name
  route_table_name          = module.route_tables[each.value.route_table_key].name
  address_prefix            = each.value.address_prefix
  next_hop_type             = each.value.next_hop_type
  next_hop_in_ip_address_fw = try(module.azurerm_firewalls[each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, null)
}
