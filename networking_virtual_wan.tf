#
#
# Virtual WAN topology (including virtual hubs, firewalls and routes configuration)
#
#

module virtual_wans {
  source   = "./modules/networking/virtual_wan"
  for_each = local.networking.virtual_wans

  settings            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  resource_groups     = module.resource_groups
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics         = local.diagnostics
  global_settings     = local.global_settings
}


# 
#
# Virtual WAN peerings with vnets
#
#

# Support for peering with vnet in another state/landing zone
data "terraform_remote_state" "peering_vhub" {
  for_each = {
    for key, peering in local.networking.vhub_peerings : key => peering
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

# Peering 
resource "azurerm_virtual_hub_connection" "vhub_connection" {
 depends_on = [module.networking, module.virtual_wans]
 for_each   = local.networking.vhub_peerings

  name                      = each.value.name
  virtual_hub_id            = try(module.virtual_wans[each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].id, null)
  remote_virtual_network_id = try(module.networking[each.value.vnet.vnet_key].id,  data.terraform_remote_state.peering_vhub[each.key].outputs[each.value.vnet.output_key][each.value.vnet.lz_key][each.value.vnet.vnet_key].id)

  hub_to_vitual_network_traffic_allowed          = try(each.value.hub_to_vitual_network_traffic_allowed, null)
  vitual_network_to_hub_gateways_traffic_allowed = try(each.value.vitual_network_to_hub_gateways_traffic_allowed, null)
  internet_security_enabled                      = try(each.value.internet_security_enabled, null)
}

# Outputs 
output virtual_wans {
  value       = module.virtual_wans
  sensitive   = false
  description = "Virtual WAN output"
}
