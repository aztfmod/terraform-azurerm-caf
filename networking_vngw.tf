module virtual_network_gateways {
  source   = "./modules/networking/virtual_network_gateways"
  for_each = try(local.networking.virtual_network_gateways, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  public_ip_addresses = local.combined_objects_public_ip_addresses
  diagnostics         = local.combined_diagnostics
  client_config       = local.client_config
  vnets               = local.combined_objects_networking
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  depends_on = [
    module.networking.public_ip_addresses
  ]
}

module virtual_network_gateway_connections {
  source   = "./modules/networking/virtual_network_gateway_connections"
  for_each = try(local.networking.virtual_network_gateway_connections, {})

  resource_group_name        = module.resource_groups[each.value.resource_group_key].name
  location                   = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  global_settings            = local.global_settings
  settings                   = each.value
  diagnostics                = local.combined_diagnostics
  client_config              = local.client_config
  virtual_network_gateway_id = module.virtual_network_gateways[each.value.virtual_network_gateway_key].id
  express_route_circuit_id   = try(module.express_route_circuits[each.value.express_route_circuit_key].id, null)
  authorization_key          = try(module.express_route_circuit_authorizations[each.value.authorization_key].authorization_key, null)
  local_network_gateway_id   = try(module.local_network_gateways[each.value.local_network_gateway_key].id, null)
  base_tags                  = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

module local_network_gateways {
  source              = "./modules/networking/local_network_gateways"
  for_each            = try(local.networking.local_network_gateways, {})
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}
