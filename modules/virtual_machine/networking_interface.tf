locals {
  nic_ids = flatten(
    [
      for nic_key in var.virtual_machine_settings[local.os_type].network_interface_keys : [
        azurerm_network_interface.nic[nic_key].id
      ]
    ]
  )
}


resource "azurecaf_naming_convention" "nic" {
  for_each      = var.networking_interfaces

  name          = each.value.name
  prefix        = var.global_settings.prefix
  resource_type = "azurerm_network_interface"
  convention    = var.global_settings.convention
}


resource "azurerm_network_interface" "nic" {
  for_each      = var.networking_interfaces

  name                = azurecaf_naming_convention.nic[each.key].result
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_servers                   = lookup(each.value, "dns_servers", null)
  enable_ip_forwarding          = lookup(each.value, "enable_ip_forwarding", false)
  enable_accelerated_networking = lookup(each.value, "enable_accelerated_networking", false)
  internal_dns_name_label       = lookup(each.value, "internal_dns_name_label", null)
  tags                          = lookup(each.value, "tags", null)

  ip_configuration {
    name                          = azurecaf_naming_convention.nic[each.key].result
    subnet_id                     = var.vnets[each.value.vnet_key].vnet_subnets[each.value.subnet_key]
    private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
    private_ip_address_version    = lookup(each.value, "private_ip_address_version", null)
    private_ip_address            = lookup(each.value, "private_ip_address", null)
    primary                       = lookup(each.value, "primary", null)
  }
}

