
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

  base_tags = try(local.global_settings.inherit_tags, false) ? coalesce(
    try(local.resource_groups[each.value.resource_group_key].tags, null),
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].tags, null),
  ) : {}

  location = lookup(each.value, "region", null) == null ? coalesce(
    try(local.resource_groups[each.value.resource_group_key].location, null),
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].location, null),
  ) : local.global_settings.regions[each.value.region]

  resource_group_name = coalesce(
    try(local.resource_groups[each.value.resource_group_key].name, null),
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
  )

  virtual_wan_id = coalesce(
    try(local.combined_objects_virtual_wans[try(each.value.virtual_wan.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan.key].virtual_wan.id, null),
    try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_wan.id, null),
    try(each.value.virtual_wan.resource_id, null),
    try(each.value.virtual_wan.id, null),
    try(each.value.virtual_wan_id, null)
  )
}
