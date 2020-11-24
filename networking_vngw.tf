module virtual_network_gateways {
  source   = "./modules/networking/virtual_network_gateways"
  for_each = try(local.networking.virtual_network_gateways, {})

  settings            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  public_ip_id        = module.public_ip_addresses[each.value.public_ip_key].id
  diagnostics         = local.diagnostics
  global_settings     = local.global_settings
}