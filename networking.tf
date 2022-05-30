output "vnets" {
  depends_on = [azurerm_virtual_network_peering.peering]
  value      = module.networking
}

output "virtual_subnets" {
  value = module.virtual_subnets
}

output "public_ip_addresses" {
  value = module.public_ip_addresses
}

output "public_ip_prefixes" {
  value = module.public_ip_prefixes
}

output "network_watchers" {
  value = module.network_watchers
}


#
#
# Virtual network
#
#

module "networking" {
  depends_on = [module.network_watchers]
  source     = "./modules/networking/virtual_network"
  for_each   = local.networking.vnets

  application_security_groups       = local.combined_objects_application_security_groups
  client_config                     = local.client_config
  ddos_id                           = try(local.combined_objects_ddos_services[try(each.value.ddos_services_lz_key, local.client_config.landingzone_key)][try(each.value.ddos_services_key, each.value.ddos_services_key)].id, "")
  diagnostics                       = local.combined_diagnostics
  global_settings                   = local.global_settings
  network_security_groups           = module.network_security_groups
  network_security_group_definition = local.networking.network_security_group_definition
  network_watchers                  = local.combined_objects_network_watchers
  route_tables                      = module.route_tables
  settings                          = each.value
  tags                              = try(each.value.tags, null)

  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}


  #assumed from remote lz only to prevent circular references
  #
  # Does not support legacy load_balancers. Prefer lb
  #
  remote_dns = {
    azurerm_firewall  = try(var.remote_objects.azurerm_firewalls, {})
    azurerm_firewalls = try(var.remote_objects.azurerm_firewalls, {})
    virtual_machines  = try(var.remote_objects.virtual_machines, {})
    lb                = try(var.remote_objects.lb, {})
  }
}

module "virtual_subnets" {
  depends_on = [module.networking]
  source     = "./modules/networking/virtual_network/subnet"
  for_each   = local.networking.virtual_subnets

  global_settings = local.global_settings
  settings        = each.value

  name                                           = each.value.name
  address_prefixes                               = try(each.value.cidr, [])
  service_endpoints                              = try(each.value.service_endpoints, [])
  enforce_private_link_endpoint_network_policies = try(each.value.enforce_private_link_endpoint_network_policies, false)
  enforce_private_link_service_network_policies  = try(each.value.enforce_private_link_service_network_policies, false)

  resource_group_name  = can(each.value.vnet.key) ? local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.key].resource_group_name : split("/", each.value.vnet.id)[4]
  virtual_network_name = can(each.value.vnet.key) ? local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.key].name : split("/", each.value.vnet.id)[8]

}

resource "azurerm_subnet_route_table_association" "rt" {
  for_each = {
    for key, subnet in local.networking.virtual_subnets : key => subnet
    if try(subnet.route_table_key, null) != null
  }

  subnet_id      = lookup(module.virtual_subnets, each.key, null).id
  route_table_id = module.route_tables[each.value.route_table_key].id
}

resource "azurerm_subnet_network_security_group_association" "nsg_vnet_association_version" {
  for_each = {
    for key, value in local.networking.virtual_subnets : key => value
    if try(local.networking.network_security_group_definition[value.nsg_key].version, 0) > 0 && try(value.nsg_key, null) != null
  }

  subnet_id                 = module.virtual_subnets[each.key].id
  network_security_group_id = module.network_security_groups[each.value.nsg_key].id
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
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}

module "public_ip_addresses" {
  source   = "./modules/networking/public_ip_addresses"
  for_each = local.networking.public_ip_addresses

  name                       = azurecaf_name.public_ip_addresses[each.key].result
  location                   = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name        = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  sku                        = try(each.value.sku, "Basic")
  allocation_method          = try(each.value.allocation_method, "Dynamic")
  ip_version                 = try(each.value.ip_version, "IPv4")
  idle_timeout_in_minutes    = try(each.value.idle_timeout_in_minutes, null)
  domain_name_label          = try(each.value.domain_name_label, null)
  reverse_fqdn               = try(each.value.reverse_fqdn, null)
  generate_domain_name_label = try(each.value.generate_domain_name_label, false)
  tags                       = try(each.value.tags, null)
  ip_tags                    = try(each.value.ip_tags, null)
  public_ip_prefix_id        = can(each.value.public_ip_prefix.key) ? local.combined_objects_public_ip_prefixes[try(each.value.public_ip_prefix.lz_key, local.client_config.landingzone_key)][each.value.public_ip_prefix.key].id : try(each.value.public_ip_prefix_id, null)
  zones = coalesce(
    try(each.value.availability_zone, ""),
    try(tostring(each.value.zones[0]), ""),
    try(each.value.sku, "Basic") == "Basic" ? "No-Zone" : "Zone-Redundant"
  )
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  diagnostics         = local.combined_diagnostics
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
}

#
#
# Public IP Prefixes
#
#

# naming convention for public IP prefixes
resource "azurecaf_name" "public_ip_prefixes" {
  for_each = local.networking.public_ip_prefixes

  name          = try(each.value.name, null)
  resource_type = "azurerm_public_ip_prefix"
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}

module "public_ip_prefixes" {
  source   = "./modules/networking/public_ip_prefixes"
  for_each = local.networking.public_ip_prefixes

  name                = azurecaf_name.public_ip_prefixes[each.key].result
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  sku                 = try(each.value.sku, "Standard")
  ip_version          = try(each.value.ip_version, "IPv4")
  tags                = try(each.value.tags, null)
  zones               = try(each.value.zones, "Zone-Redundant")
  prefix_length       = try(each.value.prefix_length, 28)
  create_pips         = try(each.value.create_pips, false)
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  diagnostics         = local.combined_diagnostics
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
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
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}

# The code tries to peer to a vnet created in the same landing zone. If it fails it tries with the data remote state
resource "azurerm_virtual_network_peering" "peering" {
  depends_on = [module.networking]
  for_each   = local.networking.vnet_peerings

  name                         = azurecaf_name.peering[each.key].result
  virtual_network_name         = can(each.value.from.virtual_network_name) ? each.value.from.virtual_network_name : local.combined_objects_networking[try(each.value.from.lz_key, local.client_config.landingzone_key)][each.value.from.vnet_key].name
  resource_group_name          = can(each.value.from.resource_group_name) ? each.value.from.resource_group_name : local.combined_objects_networking[try(each.value.from.lz_key, local.client_config.landingzone_key)][each.value.from.vnet_key].resource_group_name
  remote_virtual_network_id    = can(each.value.to.remote_virtual_network_id) ? each.value.to.remote_virtual_network_id : local.combined_objects_networking[try(each.value.to.lz_key, local.client_config.landingzone_key)][each.value.to.vnet_key].id
  allow_virtual_network_access = try(each.value.allow_virtual_network_access, true)
  allow_forwarded_traffic      = try(each.value.allow_forwarded_traffic, false)
  allow_gateway_transit        = try(each.value.allow_gateway_transit, false)
  use_remote_gateways          = try(each.value.use_remote_gateways, false)

}

# Allow creating from and to in the same deployment when vnets are in different subscriptions
# (azurerm does not access the resource id of the vnet in the from)
# use the variable vnet_peerings_v1
resource "azapi_resource" "virtualNetworkPeerings" {
  depends_on = [module.networking]
  for_each   = local.networking.vnet_peerings_v1

  type      = "Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2021-05-01"
  name      = each.value.name
  parent_id = can(each.value.from.id) ? each.value.from.id : local.combined_objects_networking[try(each.value.from.lz_key, local.client_config.landingzone_key)][each.value.from.vnet_key].id

  body = jsonencode({
    properties = {
      allowForwardedTraffic     = try(each.value.allow_forwarded_traffic, false)
      allowGatewayTransit       = try(each.value.allow_gateway_transit, false)
      allowVirtualNetworkAccess = try(each.value.allow_virtual_network_access, true)
      doNotVerifyRemoteGateways = try(each.value.do_not_verify_remote_gateways, false)
      useRemoteGateways         = try(each.value.use_remote_gateways, false)
      remoteVirtualNetwork = {
        id = can(each.value.to.remote_virtual_network_id) || can(each.value.to.id) ? try(each.value.to.remote_virtual_network_id, each.value.to.id) : local.combined_objects_networking[try(each.value.to.lz_key, local.client_config.landingzone_key)][each.value.to.vnet_key].id
      }
    }
  })

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
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}

module "route_tables" {
  source   = "./modules/networking/route_tables"
  for_each = local.networking.route_tables

  name                          = azurecaf_name.route_tables[each.key].result
  location                      = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name           = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags                     = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  disable_bgp_route_propagation = try(each.value.disable_bgp_route_propagation, null)
  tags                          = try(each.value.tags, null)
}

resource "azurecaf_name" "routes" {
  for_each = local.networking.azurerm_routes

  name          = try(each.value.name, null)
  resource_type = "azurerm_route"
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}


module "routes" {
  source   = "./modules/networking/routes"
  for_each = local.networking.azurerm_routes

  name                   = azurecaf_name.routes[each.key].result
  resource_group_name    = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  route_table_name       = module.route_tables[each.value.route_table_key].name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(each.value.next_hop_in_ip_address, null) : null
  next_hop_in_ip_address_fw = try(lower(each.value.next_hop_type), null) == "virtualappliance" ? try(coalesce(
    try(local.combined_objects_azurerm_firewalls[try(each.value.private_ip_keys.azurerm_firewall.lz_key, local.client_config.landingzone_key)][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, null),
    try(local.combined_objects_azurerm_firewalls[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.private_ip_keys.azurerm_firewall.key].ip_configuration[each.value.private_ip_keys.azurerm_firewall.interface_index].private_ip_address, null)
  ), null) : null

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
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
}

resource "azurerm_network_ddos_protection_plan" "ddos_protection_plan" {
  for_each = local.networking.ddos_services

  name                = azurecaf_name.ddos_protection_plan[each.key].result
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  tags                = try(local.global_settings.inherit_tags, false) ? merge(try(local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags, {}), try(each.value.tags, {})) : try(each.value.tags, {})
}

output "ddos_services" {
  value = azurerm_network_ddos_protection_plan.ddos_protection_plan
}

#
#
# Network Watchers
#
#
module "network_watchers" {
  source   = "./modules/networking/network_watcher"
  for_each = local.networking.network_watchers

  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  settings            = each.value
  tags                = try(each.value.tags, null)
  global_settings     = local.global_settings
}




module "relay_hybrid_connection" {
  source   = "./modules/networking/relay_hybrid_connection"
  for_each = local.networking.relay_hybrid_connection

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = can(each.value.resource_group.name) ? each.value.resource_group.name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name

  remote_objects = {
    resource_group  = local.combined_objects_resource_groups
    relay_namespace = local.combined_objects_relay_namespace
  }
}
output "relay_hybrid_connection" {
  value = module.relay_hybrid_connection
}

module "relay_namespace" {
  source   = "./modules/networking/relay_namespace"
  for_each = local.networking.relay_namespace

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = can(each.value.resource_group.name) ? each.value.resource_group.name : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location

  remote_objects = {
    resource_group = local.combined_objects_resource_groups
  }
}
output "relay_namespace" {
  value = module.relay_namespace
}