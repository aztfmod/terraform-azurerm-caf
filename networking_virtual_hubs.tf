#
#
# Virtual Hubs is used when deployed outside of the virtual wan
#
#

# Outputs
output "virtual_hubs" {
  value = module.virtual_hubs

  description = "Virtual hubs output"
}

module "virtual_hubs" {
  source   = "./modules/networking/virtual_wan/virtual_hub"
  for_each = local.networking.virtual_hubs

  client_config       = local.client_config
  global_settings     = local.global_settings
  public_ip_addresses = local.combined_objects_public_ip_addresses
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  tags                = try(local.global_settings.inherit_tags, false) ? merge(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].tags, try(each.value.tags, null)) : {}
  virtual_hub_config  = each.value
  virtual_networks    = local.combined_objects_networking
  vwan_id             = can(each.value.virtual_wan) ? local.combined_objects_virtual_wans[try(each.value.virtual_wan.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan.key].virtual_wan.id : null
}

