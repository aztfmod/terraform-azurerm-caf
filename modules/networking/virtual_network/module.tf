// Creates the networks virtual network, the subnets and associated NSG, with a special section for AzureFirewallSubnet
resource "azurecaf_name" "caf_name_vnet" {

  name          = var.settings.vnet.name
  resource_type = "azurerm_virtual_network"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_virtual_network" "vnet" {
  name                = azurecaf_name.caf_name_vnet.result
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.settings.vnet.address_space
  tags                = local.tags

  dns_servers = flatten(
    concat(
      try(lookup(var.settings.vnet, "dns_servers", [])),
      try(local.dns_servers_process, [])
    )
  )

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_id != "" || can(var.global_settings["ddos_protection_plan_id"]) ? [1] : []

    content {
      id     = var.ddos_id != "" ? var.ddos_id : var.global_settings["ddos_protection_plan_id"]
      enable = true
    }
  }

  lifecycle {
    ignore_changes = [name]
  }
}

module "special_subnets" {
  source = "./subnet"

  for_each                                       = lookup(var.settings, "specialsubnets", {})
  name                                           = each.value.name
  global_settings                                = var.global_settings
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = lookup(each.value, "cidr", [])
  service_endpoints                              = lookup(each.value, "service_endpoints", [])
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)
  enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", false)
  settings                                       = each.value
}

module "subnets" {
  source = "./subnet"

  for_each                                       = lookup(var.settings, "subnets", {})
  name                                           = each.value.name
  global_settings                                = var.global_settings
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = lookup(each.value, "cidr", [])
  service_endpoints                              = lookup(each.value, "service_endpoints", [])
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)
  enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", false)
  settings                                       = each.value
}

module "nsg" {
  source = "./nsg"

  application_security_groups       = var.application_security_groups
  client_config                     = var.client_config
  diagnostics                       = var.diagnostics
  global_settings                   = var.global_settings
  location                          = var.location
  network_security_groups           = var.network_security_groups
  network_security_group_definition = var.network_security_group_definition
  resource_group                    = var.resource_group_name
  subnets                           = try(var.settings.subnets, {})
  network_watchers                  = var.network_watchers
  tags                              = local.tags
  virtual_network_name              = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet_route_table_association" "rt" {
  for_each = {
    for key, subnet in merge(lookup(var.settings, "subnets", {}), lookup(var.settings, "specialsubnets", {})) : key => subnet
    if try(subnet.route_table_key, null) != null
  }

  subnet_id      = coalesce(lookup(module.subnets, each.key, null), lookup(module.special_subnets, each.key, null)).id
  route_table_id = var.route_tables[each.value.route_table_key].id
}

resource "azurerm_subnet_network_security_group_association" "nsg_vnet_association" {
  for_each = {
    for key, value in try(var.settings.subnets, {}) : key => value
    if try(var.network_security_group_definition[value.nsg_key].version, 0) == 0 && try(value.nsg_key, null) != null
  }

  subnet_id                 = module.subnets[each.key].id
  network_security_group_id = module.nsg.nsg_obj[each.key].id
}


resource "azurerm_subnet_network_security_group_association" "nsg_vnet_association_version" {
  for_each = {
    for key, value in try(var.settings.subnets, {}) : key => value
    if try(var.network_security_group_definition[value.nsg_key].version, 0) > 0 && try(value.nsg_key, null) != null
  }

  subnet_id                 = module.subnets[each.key].id
  network_security_group_id = var.network_security_groups[each.value.nsg_key].id
}

locals {
  dns_servers_process = can(var.settings.vnet.dns_servers_keys) == false ? [] : concat(
    [
      for obj in try(var.settings.vnet.dns_servers_keys, {}) : #o.ip
      coalesce(
        try(var.remote_dns[obj.resource_type][obj.lz_key][obj.key].virtual_hub[obj.interface_index].private_ip_address, null),
        try(var.remote_dns[obj.resource_type][obj.lz_key][obj.key].virtual_hub.0.private_ip_address, null),
        try(var.remote_dns[obj.resource_type][obj.lz_key][obj.key].ip_configuration[obj.interface_index].private_ip_address, null),
        try(var.remote_dns[obj.resource_type][obj.lz_key][obj.key].ip_configuration.0.private_ip_address, null)
      )
      if contains(["azurerm_firewall", "azurerm_firewalls"], obj.resource_type)
    ],
    [
      for obj in try(var.settings.vnet.dns_servers_keys, {}) :
      var.remote_dns.lb[obj.lz_key][obj.key].private_ip_addresses
      if contains(["lb"], obj.resource_type)
    ],
    [
      for obj in try(var.settings.vnet.dns_servers_keys, {}) :
      var.remote_dns.virtual_machines[obj.lz_key][obj.key].ip_configuration[obj.nic_key].private_ip_addresses
      if contains(["virtual_machines", "virtual_machine"], obj.resource_type)
    ]
  )
}
