output vnets {
  depends_on = [azurerm_virtual_network_peering.peering]
  value      = module.networking
  sensitive  = true
}

output public_ip_addresses {
  value     = module.public_ip_addresses
  sensitive = true
}


#
#
# Virtual network
#
#

module "networking" {
  source   = "./modules/networking/virtual_network"
  for_each = try(var.networking.vnets, {})

  location                          = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name               = module.resource_groups[each.value.resource_group_key].name
  settings                          = each.value
  network_security_group_definition = local.networking.network_security_group_definition
  route_tables                      = module.route_tables
  tags                              = try(each.value.tags, null)
  diagnostics                       = local.diagnostics
  global_settings                   = local.global_settings
  ddos_id                           = try(azurerm_network_ddos_protection_plan.ddos_protection_plan[each.value.ddos_services_key].id, "")
  base_tags                         = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

#
#
# Public IP Addresses
#
#

# naming convention for public IP address
resource "azurecaf_name" "public_ip_addresses" {
  for_each = local.networking.public_ip_addresses

  name          = try(each.value.name, null)
  resource_type = "azurerm_public_ip"
  prefixes      = [local.global_settings.prefix]
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
}

module public_ip_addresses {
  source   = "./modules/networking/public_ip_addresses"
  for_each = local.networking.public_ip_addresses

  name                    = azurecaf_name.public_ip_addresses[each.key].result
  resource_group_name     = module.resource_groups[each.value.resource_group_key].name
  location                = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
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
  base_tags               = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

#
#
# Vnet peering
#  (Support vnet in remote tfstates)
#

# naming convention for peering name
resource "azurecaf_name" "peering" {
  for_each = local.networking.vnet_peerings

  name          = try(each.value.name, "")
  resource_type = "azurerm_virtual_network_peering"
  prefixes      = [local.global_settings.prefix]
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
}

# The code tries to peer to a vnet created in the same landing zone. If it fails it tries with the data remote state
resource "azurerm_virtual_network_peering" "peering" {
  depends_on = [module.networking]
  for_each   = local.networking.vnet_peerings

  name                         = azurecaf_name.peering[each.key].result
  virtual_network_name         = try(each.value.from.lz_key, null) == null ? local.combined_objects_networking[local.client_config.landingzone_key][each.value.from.vnet_key].name : local.combined_objects_networking[each.value.from.lz_key][each.value.from.vnet_key].name
  resource_group_name          = try(each.value.from.lz_key, null) == null ? local.combined_objects_networking[local.client_config.landingzone_key][each.value.from.vnet_key].resource_group_name : local.combined_objects_networking[each.value.from.lz_key][each.value.from.vnet_key].resource_group_name
  remote_virtual_network_id    = try(each.value.to.lz_key, null) == null ? local.combined_objects_networking[local.client_config.landingzone_key][each.value.to.vnet_key].id : local.combined_objects_networking[each.value.to.lz_key][each.value.to.vnet_key].id
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
resource "azurecaf_name" "route_tables" {
  for_each = local.networking.route_tables

  name          = try(each.value.name, null)
  resource_type = "azurerm_route_table"
  prefixes      = [local.global_settings.prefix]
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
}

module "route_tables" {
  source   = "./modules/networking/route_tables"
  for_each = local.networking.route_tables

  name                          = azurecaf_name.route_tables[each.key].result
  resource_group_name           = module.resource_groups[each.value.resource_group_key].name
  location                      = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  disable_bgp_route_propagation = try(each.value.disable_bgp_route_propagation, null)
  tags                          = try(each.value.tags, null)
  base_tags                     = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

resource "azurecaf_name" "routes" {
  for_each = local.networking.azurerm_routes

  name          = try(each.value.name, null)
  resource_type = "azurerm_route"
  prefixes      = [local.global_settings.prefix]
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
}


data "terraform_remote_state" "firewall" {
  for_each = {
    for key, route in local.networking.azurerm_routes : key => route
    if try(route.remote_tfstate.tfstate_key, null) != null
  }

  backend = "azurerm"
  config = {
    storage_account_name = var.tfstates[each.value.remote_tfstate.tfstate_key].storage_account_name
    container_name       = var.tfstates[each.value.remote_tfstate.tfstate_key].container_name
    resource_group_name  = var.tfstates[each.value.remote_tfstate.tfstate_key].resource_group_name
    key                  = var.tfstates[each.value.remote_tfstate.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[each.value.remote_tfstate.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[each.value.remote_tfstate.tfstate_key].tenant_id : null
  }
}
module "routes" {
  source   = "./modules/networking/routes"
  for_each = local.networking.azurerm_routes

  name                      = azurecaf_name.routes[each.key].result
  resource_group_name       = module.resource_groups[each.value.resource_group_key].name
  route_table_name          = module.route_tables[each.value.route_table_key].name
  address_prefix            = each.value.address_prefix
  next_hop_type             = each.value.next_hop_type
  next_hop_in_ip_address_fw = try(each.value.remote_tfstate.tfstate_key, null) == null ? try(module.azurerm_firewalls[each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, null) : data.terraform_remote_state.firewall[each.key].outputs[each.value.remote_tfstate.output_key][each.value.remote_tfstate.fw_key].ip_configuration[each.value.remote_tfstate.interface_index].private_ip_address
}

#
#
# Azure DDoS
#
#

# naming convention
resource "azurecaf_name" "ddos_protection_plan" {
  for_each = local.networking.ddos_services

  name          = try(each.value.name, null)
  resource_type = "azurerm_network_ddos_protection_plan"
  prefixes      = [local.global_settings.prefix]
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
}

resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  for_each = local.networking.ddos_services

  name                = azurecaf_name.ddos_protection_plan[each.key].result
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  tags                = try(local.global_settings.inherit_tags, false) ? merge(module.resource_groups[each.value.resource_group_key].tags, each.value.tags) : try(each.value.tags, null)
}


