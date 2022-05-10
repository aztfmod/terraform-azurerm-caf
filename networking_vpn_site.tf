
#
#
# VPN Sites
#
#

output "vpn_sites" {
  value = module.vpn_sites
}

module "vpn_sites" {
  depends_on = [module.virtual_wans]
  source     = "./modules/networking/vpn_site"
  for_each   = local.networking.vpn_sites

  global_settings = local.global_settings
  settings        = each.value

  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

  virtual_wan_id = can(each.value.virtual_wan_id) || can(each.value.virtual_wan.id) ? try(each.value.virtual_wan_id, each.value.virtual_wan.id) : local.combined_objects_virtual_wans[try(each.value.virtual_wan.lz_key, each.value.lz_key, local.client_config.landingzone_key)][try(each.value.virtual_wan.key, each.value.virtual_wan_key)].virtual_wan.id
}
