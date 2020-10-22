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
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}


#
#
# Virtual WAN peerings with vnets
#
#

# Peering
resource "azurerm_virtual_hub_connection" "vhub_connection" {
  depends_on = [module.networking, module.virtual_wans]
  for_each   = local.networking.vhub_peerings

  name                      = each.value.name
  virtual_hub_id            = try(module.virtual_wans[each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].id, null)
  remote_virtual_network_id = lookup(each.value.vnet, "lz_key", null) == null ? local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet.vnet_key].id : local.combined_objects_networking[each.value.lz_key].vnets[each.value.vnet.vnet_key].id
  internet_security_enabled = try(each.value.internet_security_enabled, null)
}

# Outputs
output virtual_wans {
  value       = module.virtual_wans
  sensitive   = false
  description = "Virtual WAN output"
}
