locals {
  nic_ids = flatten(
    [
      for nic_key in var.settings.virtual_machine_settings[var.settings.os_type].network_interface_keys : [
        azurerm_network_interface.nic[nic_key].id
      ]
    ]
  )
}


resource "azurecaf_naming_convention" "nic" {
  for_each = var.settings.networking_interfaces

  name          = each.value.name
  prefix        = var.global_settings.prefix
  resource_type = "azurerm_network_interface"
  convention    = var.global_settings.convention
}


resource "azurerm_network_interface" "nic" {
  for_each = var.settings.networking_interfaces

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
    subnet_id                     = try(each.value.networking.remote_tfstate, null) == null ? var.vnets[each.value.networking.vnet_key].subnets[each.value.networking.subnet_key].id : data.terraform_remote_state.vnets[each.key].outputs[each.value.networking.remote_tfstate.output_key][each.value.networking.remote_tfstate.lz_key][each.value.networking.remote_tfstate.vnet_key].subnets[each.value.networking.remote_tfstate.subnet_key].id
    private_ip_address_allocation = lookup(each.value, "private_ip_address_allocation", "Dynamic")
    private_ip_address_version    = lookup(each.value, "private_ip_address_version", null)
    private_ip_address            = lookup(each.value, "private_ip_address", null)
    primary                       = lookup(each.value, "primary", null)
    public_ip_address_id          = try(var.public_ip_addresses[each.value.public_ip_address_key].id, null)
  }
}

data "terraform_remote_state" "vnets" {
  for_each = {
    for key, nic in var.settings.networking_interfaces : key => nic
    if try(nic.networking.remote_tfstate, null) != null
  }

  backend = "azurerm"
  config = {
    storage_account_name = var.tfstates[each.value.networking.remote_tfstate.tfstate_key].storage_account_name
    container_name       = var.tfstates[each.value.networking.remote_tfstate.tfstate_key].container_name
    resource_group_name  = var.tfstates[each.value.networking.remote_tfstate.tfstate_key].resource_group_name
    key                  = var.tfstates[each.value.networking.remote_tfstate.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[each.value.networking.remote_tfstate.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[each.value.networking.remote_tfstate.tfstate_key].tenant_id : null
  }
}

# Example of a nic configuration with vnet on a remote state

# Define the number of networking cards to attach the virtual machine
# networking_interfaces = {
#   nic0 = {
#     # AKS rely on a remote network and need the details of the tfstate to connect (tfstate_key), assuming RBAC authorization.
#     networking = {
#       remote_tfstate = {
#         tfstate_key = "networking_aks"
#         output_key  = "vnets"
#         lz_key      = "networking_aks"
#         vnet_key    = "hub_rg1"
#         subnet_key  = "jumpbox"
#       }
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