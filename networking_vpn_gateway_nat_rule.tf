
#
#
# VPN Gateway NAT Rule used for VPN Gatway Connection
#
#

output "vpn_gateway_nat_rules" {
  value = module.vpn_gateway_nat_rules
}

module "vpn_gateway_nat_rules" {
  depends_on = [module.virtual_wans, module.vpn_sites, module.virtual_hubs]
  source     = "./modules/networking/vpn_gateway_nat_rule"
  for_each   = local.networking.vpn_gateway_nat_rules

  settings        = each.value
  global_settings = local.global_settings
  client_config   = local.client_config

  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  vpn_gateway_id      = can(each.value.virtual_hub_gateway_id) || can(each.value.virtual_wan) ? try(each.value.virtual_hub_gateway_id, local.combined_objects_virtual_wans[try(each.value.virtual_wan.lz_key, each.value.lz_key, local.client_config.landingzone_key)][try(each.value.virtual_wan.key, each.value.virtual_wan_key)].virtual_hubs[try(each.value.virtual_hub.key, each.value.virtual_hub_key)].s2s_gateway.id) : local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].s2s_gateway.id
}
