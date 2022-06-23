locals {
  nic_ids = flatten(
    [
      local.network_interface_ids,
      try(var.settings.networking_interface_ids, [])
    ]
  )

  network_interface_ids = flatten(
    [
      for nic_key in try(var.settings.virtual_machine_settings[var.settings.os_type].network_interface_keys, []) : [
        azurerm_network_interface.nic[nic_key].id
      ]
    ]
  )
  # network_subnets = flatten([
  #   for network_key, network in var.networks : [
  #     for subnet_key, subnet in network.subnets : {
  #       network_key = network_key
  #       subnet_key  = subnet_key
  #       network_id  = aws_vpc.example[network_key].id
  #       cidr_block  = subnet.cidr_block
  #     }
  #   ]
  # ])
  # element(flatten(...),count.index)
}

resource "azurecaf_name" "nic" {
  for_each = var.settings.networking_interfaces

  name          = each.value.name
  resource_type = "azurerm_network_interface"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_network_interface" "nic" {
  for_each = var.settings.networking_interfaces
  # lifecycle {
  #   ignore_changes = [resource_group_name, location]
  # }
  name                = azurecaf_name.nic[each.key].result
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_servers                   = lookup(each.value, "dns_servers", null)
  enable_ip_forwarding          = lookup(each.value, "enable_ip_forwarding", false)
  enable_accelerated_networking = lookup(each.value, "enable_accelerated_networking", false)
  internal_dns_name_label       = lookup(each.value, "internal_dns_name_label", null)
  tags                          = merge(local.tags, try(each.value.tags, null))

  ip_configuration {
    name                          = azurecaf_name.nic[each.key].result
    subnet_id                     = can(each.value.subnet_id) ? each.value.subnet_id : var.vnets[try(each.value.lz_key, var.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
    private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
    private_ip_address_version    = lookup(each.value, "private_ip_address_version", null)
    private_ip_address            = lookup(each.value, "private_ip_address", null)
    primary                       = lookup(each.value, "primary", null)
    public_ip_address_id          = can(each.value.public_address_id) || can(try(each.value.public_ip_address.key, each.value.public_ip_address_key)) == false ? try(each.value.public_address_id, null) : var.public_ip_addresses[try(each.value.public_ip_address.lz_key, var.client_config.landingzone_key)][try(each.value.public_ip_address.key, each.value.public_ip_address_key)].id 

    # Public ip address id logic in previous version was bugged, as it checks for var.client_config.landingzone_key prior to each.value.lz_key. thus, in the new logic to ensure backward compatible, only each.public_ip_address.lz_key is considered and not each.value.lz_key for public ip.

  }

  dynamic "ip_configuration" {
    for_each = try(each.value.ip_configurations, {})

    content {
      name                          = ip_configuration.value.name
      subnet_id                     = can(ip_configuration.value.subnet_id) ? ip_configuration.value.subnet_id : var.vnets[try(ip_configuration.value.lz_key, var.client_config.landingzone_key)][ip_configuration.value.vnet_key].subnets[ip_configuration.value.subnet_key].id
      private_ip_address_allocation = try(ip_configuration.value.private_ip_address_allocation, "Dynamic")
      private_ip_address_version    = lookup(ip_configuration.value, "private_ip_address_version", null)
      private_ip_address            = lookup(ip_configuration.value, "private_ip_address", null)
      primary                       = lookup(ip_configuration.value, "primary", null)
      public_ip_address_id          = can(ip_configuration.value.public_address_id) || can(try(ip_configuration.value.public_address_id.key,ip_configuration.value.public_ip_address_key)) == false ? try(ip_configuration.value.public_address_id, null) : var.public_ip_addresses[try(ip_configuration.value.public_ip_address.lz_key, var.client_config.landingzone_key)][try(ip_configuration.value.public_ip_address.key,ip_configuration.value.public_ip_address_key)].id
    }
  }
}

# Example of a nic configuration with vnet on a remote state

# Define the number of networking cards to attach the virtual machine
# networking_interfaces = {
#   nic0 = {
#     # AKS rely on a remote network and need the details of the tfstate to connect (tfstate_key), assuming RBAC authorization.
#     lz_key                  = "networking_aks"
#     vnet_key                = "hub_rg1"
#     subnet_key              = "jumpbox"
#     name                    = "0"
#     enable_ip_forwarding    = false
#     internal_dns_name_label = "nic0"
#     // Prefer network_security_group orver nsg_key. Will be removed in version 6
#     nsg_key                 = "data"       // requires a version 1 nsg definition (see compute/vm/210-vm-bastion-winrm example)
#
#     network_security_group = {
#       # lz_key = ""
#      key = "data"
#     }
#
#     ip_configurations = {
#       conf2 = {
#         name                    = "nic0-conf2"
#         vnet_key                = "vnet_region1"
#         subnet_key              = "bastion"
#         name                    = "0-bastion_host"
#         enable_ip_forwarding    = false
#         internal_dns_name_label = "bastion-host-nic0"
#         public_ip_address_key   = "bastion_host_pip1"
#       }
#    }
#     # you can setup up to 5 profiles
#     diagnostic_profiles = {
#       operations = {
#         definition_key   = "nic"
#         destination_type = "log_analytics"
#         destination_key  = "central_logs"
#       }
#     }
#   }
# }

resource "azurerm_network_interface_security_group_association" "nic" {
  for_each = {
    for key, value in try(var.settings.networking_interfaces, {}) : key => value
    if try(try(value.nsg_key, value.nsg_id), null) != null
  }

  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = try(each.value.nsg_id, var.network_security_groups[try(each.value.network_security_group.lz_key, var.client_config.landingzone_key)][each.value.nsg_key].id)
}


resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  for_each = {
    for key, value in try(var.settings.networking_interfaces, {}) : key => value
    if try(value.network_security_group, null) != null
  }

  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = var.network_security_groups[try(each.value.network_security_group.lz_key, var.client_config.landingzone_key)][each.value.network_security_group.key].id
}