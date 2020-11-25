module virtual_network_gateways {
  source   = "./modules/networking/virtual_network_gateways"
  for_each = try(local.networking.virtual_network_gateways, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  public_ip_address_id         = module.public_ip_addresses[each.value.public_ip_key].id
  subnet_id           = module.networking[each.value.vnet_key].subnets["GatewaySubnet"].id
  diagnostics         = local.diagnostics
  global_settings     = local.global_settings
  type = each.value.type
  sku = each.value.sku
  active_active = each.value.active_active
  enable_bgp = each.value.enable_bgp 
  name = each.value.name
  ip_config_name = each.value.ip_config_name
  private_ip_address_allocation  = each.value.private_ip_address_allocation 
  tags                = try(each.value.tags, null)
}