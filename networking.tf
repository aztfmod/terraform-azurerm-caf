

output vnets {
  depends_on = [azurerm_virtual_network_peering.peering]
  value      = module.networking
  sensitive  = true
}

#
#
# Virtual network
#
#

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

#
#
# Public IP Addresses
#
#

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

#
#
# Vnet peering
#  (Support vnet in remote tfstates)
#

data "terraform_remote_state" "peering_from" {
  for_each = {
    for key, peering in local.networking.vnet_peerings : key => peering
    if try(peering.from.tfstate_key, null) != null
  }

  backend = "azurerm"
  config = {
    storage_account_name = var.tfstates[each.value.from.tfstate_key].storage_account_name
    container_name       = var.tfstates[each.value.from.tfstate_key].container_name
    resource_group_name  = var.tfstates[each.value.from.tfstate_key].resource_group_name
    key                  = var.tfstates[each.value.from.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[each.value.from.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[each.value.from.tfstate_key].tenant_id : null
  }
}

data "terraform_remote_state" "peering_to" {
  for_each = {
    for key, peering in local.networking.vnet_peerings : key => peering
    if try(peering.to.tfstate_key, null) != null
  }

  backend = "azurerm"
  config = {
    storage_account_name = var.tfstates[each.value.to.tfstate_key].storage_account_name
    container_name       = var.tfstates[each.value.to.tfstate_key].container_name
    resource_group_name  = var.tfstates[each.value.to.tfstate_key].resource_group_name
    key                  = var.tfstates[each.value.to.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[each.value.to.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[each.value.to.tfstate_key].tenant_id : null
  }
}

resource "azurerm_virtual_network_peering" "peering" {
  depends_on = [module.networking]
  for_each   = local.networking.vnet_peerings

  name                         = each.value.name
  virtual_network_name         = try(module.networking[each.value.from.vnet_key].name, data.terraform_remote_state.peering_from[each.key].outputs[each.value.from.output_key][each.value.from.lz_key][each.value.from.vnet_key].name)
  resource_group_name          = try(module.networking[each.value.from.vnet_key].resource_group_name, data.terraform_remote_state.peering_from[each.key].outputs[each.value.from.output_key][each.value.from.lz_key][each.value.from.vnet_key].resource_group_name)
  remote_virtual_network_id    = try(module.networking[each.value.to.vnet_key].id, data.terraform_remote_state.peering_to[each.key].outputs[each.value.to.output_key][each.value.to.lz_key][each.value.to.vnet_key].id)
  allow_virtual_network_access = try(each.value.allow_virtual_network_access, true)
  allow_forwarded_traffic      = try(each.value.allow_forwarded_traffic, false)
  allow_gateway_transit        = try(each.value.allow_gateway_transit, false)
  use_remote_gateways          = try(each.value.use_remote_gateways, false)
}

#
#
# Route tables and routes
#
#

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
