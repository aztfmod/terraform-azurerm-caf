module "virtual_network_gateways" {
  source   = "./modules/networking/virtual_network_gateways"
  for_each = try(local.networking.virtual_network_gateways, {})

  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  public_ip_addresses = local.combined_objects_public_ip_addresses
  diagnostics         = local.combined_diagnostics
  client_config       = local.client_config
  vnets               = local.combined_objects_networking
  global_settings     = local.global_settings
  settings            = each.value
  depends_on = [
    module.networking.public_ip_addresses
  ]
}

module "virtual_network_gateway_connections" {
  source   = "./modules/networking/virtual_network_gateway_connections"
  for_each = try(local.networking.virtual_network_gateway_connections, {})

  location                 = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name      = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags                = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  global_settings          = local.global_settings
  settings                 = each.value
  diagnostics              = local.combined_diagnostics
  client_config            = local.client_config
  local_network_gateway_id = try(module.local_network_gateways[each.value.local_network_gateway_key].id, null)

  virtual_network_gateway_id = coalesce(
    try(module.virtual_network_gateways[each.value.virtual_network_gateway_key].id, null)
  )

  express_route_circuit_id = try(coalesce(
    try(module.express_route_circuits[each.value.express_route_circuit_key].id, null),
    try(module.express_route_circuits[each.value.express_route_circuit.key].id, null),
    try(each.value.express_route_circuit.id, null)
    ),
    null
  )

  authorization_key = try(
    coalesce(
      try(module.express_route_circuit_authorizations[each.value.authorization_key].authorization_key, null),
      try(each.value.express_route_circuit_authorization, null)
    ),
    null
  )

}

module "local_network_gateways" {
  source              = "./modules/networking/local_network_gateways"
  for_each            = try(local.networking.local_network_gateways, {})
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

}
