locals {
  nic_ids = flatten(
    [
      for nic_key in var.settings.virtual_machine_settings[var.settings.os_type].network_interface_keys : [
        azurerm_network_interface.nic[nic_key].id
      ]
    ]
  )
}

resource "azurecaf_name" "nic" {
  for_each = var.settings.networking_interfaces

  name          = each.value.name
  resource_type = "azurerm_network_interface"
  prefixes      = [var.global_settings.prefix]
  random_length = try(var.global_settings.random_length, null)
  clean_input   = true
  passthrough   = try(var.global_settings.passthrough, false)
}

resource "azurerm_network_interface" "nic" {
  for_each = var.settings.networking_interfaces

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
    subnet_id                     = try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
    private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
    private_ip_address_version    = lookup(each.value, "private_ip_address_version", null)
    private_ip_address            = lookup(each.value, "private_ip_address", null)
    primary                       = lookup(each.value, "primary", null)
    public_ip_address_id          = try(var.public_ip_addresses[each.value.public_ip_address_key].id, null)
  }
}

# Example of a nic configuration with vnet on a remote state

# Define the number of networking cards to attach the virtual machine
# networking_interfaces = {
#   nic0 = {
#     # AKS rely on a remote network and need the details of the tfstate to connect (tfstate_key), assuming RBAC authorization.
#     networking = {
#       lz_key      = "networking_aks"
#       vnet_key    = "hub_rg1"
#       subnet_key  = "jumpbox"
#     }
#     name                    = "0"
#     enable_ip_forwarding    = false
#     internal_dns_name_label = "nic0"

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