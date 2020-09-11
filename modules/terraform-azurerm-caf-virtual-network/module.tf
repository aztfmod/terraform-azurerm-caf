// Creates the networks virtual network, the subnets and associated NSG, with a special section for AzureFirewallSubnet
# resource "azurecaf_naming_convention" "caf_name_vnet" {
#   name          = var.settings.vnet.name
#   prefix        = var.prefix != "" ? var.prefix : null
#   postfix       = var.postfix != "" ? var.postfix : null
#   max_length    = var.max_length != "" ? var.max_length : null
#   resource_type = "azurerm_virtual_network"
#   convention    = var.convention
# }

resource "azurecaf_name" "caf_name_vnet" {

  name          = var.settings.vnet.name
  resource_type = "azurerm_public_ip"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_virtual_network" "vnet" {
  name                = azurecaf_name.caf_name_vnet.result
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.settings.vnet.address_space
  tags                = local.tags

  dns_servers = lookup(var.settings.vnet, "dns", null)

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_id != "" ? [1] : []

    content {
      id     = var.ddos_id
      enable = true
    }
  }
}

module "special_subnets" {
  source = "./subnet"

  for_each                                       = lookup(var.settings, "specialsubnets", {})
  name                                           = each.value.name
  global_settings = var.global_settings
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = lookup(each.value, "cidr", [])
  delegation                                     = lookup(each.value, "delegation", {})
  service_endpoints                              = lookup(each.value, "service_endpoints", [])
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)
  enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", false)
  
}

module "subnets" {
  source = "./subnet"

  for_each                                       = lookup(var.settings, "subnets", {})
  name                                           = each.value.name
  global_settings = var.global_settings
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = lookup(each.value, "cidr", [])
  delegation                                     = lookup(each.value, "delegation", {})
  service_endpoints                              = lookup(each.value, "service_endpoints", [])
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)
  enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", false)
}

module "nsg" {
  source = "./nsg"

  resource_group                    = var.resource_group_name
  virtual_network_name              = azurerm_virtual_network.vnet.name
  subnets                           = var.settings.subnets
  tags                              = local.tags
  location                          = var.location
  network_security_group_definition = var.network_security_group_definition
  diagnostics                       = var.diagnostics
  global_settings = var.global_settings
}

resource "azurerm_subnet_route_table_association" "rt" {
  for_each = {
    for key, subnet in lookup(var.settings, "subnets", {}) : key => subnet
    if lookup(subnet, "route_table_key", null) != null
  }

  subnet_id      = module.subnets[each.key].id
  route_table_id = var.route_tables[each.value.route_table_key].id
}

# module "traffic_analytics" {
#   source = "./traffic_analytics"

#   rg                      = var.resource_group_name
#   tags                    = var.tags
#   location                = var.location
#   log_analytics_workspace = var.log_analytics_workspace
#   diagnostics_map         = var.diagnostics_map
#   nw_config               = lookup(var.networking_object, "netwatcher", {})
#   nsg                     = module.nsg.nsg_obj
#   netwatcher              = var.netwatcher
# }

resource "azurerm_subnet_network_security_group_association" "nsg_vnet_association" {
  for_each = module.subnets

  subnet_id                 = each.value.id
  network_security_group_id = module.nsg.nsg_obj[each.key].id
}

