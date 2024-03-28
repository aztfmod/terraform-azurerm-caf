
#
#
# VPN Gateway Connection
#
#

output "vpn_gateway_connections" {
  value = module.vpn_gateway_connections
}

module "vpn_gateway_connections" {
  depends_on = [module.virtual_wans, module.vpn_sites, module.virtual_hubs]
  source     = "./modules/networking/vpn_gateway_connection"
  for_each   = local.networking.vpn_gateway_connections

  settings        = each.value
  global_settings = local.global_settings
  client_config   = local.client_config
  vpn_sites       = local.combined_objects_vpn_sites
  route_tables    = local.combined_objects_virtual_hub_route_tables
  nat_rules       = local.combined_objects_vpn_gateway_nat_rules

  default_route_table_id = can(each.value.virtual_wan) ? local.combined_objects_virtual_wans[try(each.value.virtual_wan.lz_key, each.value.lz_key, local.client_config.landingzone_key)][try(each.value.virtual_wan.key, each.value.virtual_wan_key)].virtual_hubs[try(each.value.virtual_hub.key, each.value.virtual_hub_key)].default_route_table_id : local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].default_route_table_id
  vpn_gateway_id         = can(each.value.virtual_hub_gateway_id) || can(each.value.virtual_wan) ? try(each.value.virtual_hub_gateway_id, local.combined_objects_virtual_wans[try(each.value.virtual_wan.lz_key, each.value.lz_key, local.client_config.landingzone_key)][try(each.value.virtual_wan.key, each.value.virtual_wan_key)].virtual_hubs[try(each.value.virtual_hub.key, each.value.virtual_hub_key)].s2s_gateway.id) : local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].s2s_gateway.id
}
