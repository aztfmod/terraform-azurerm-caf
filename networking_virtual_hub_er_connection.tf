
module "virtual_hub_er_gateway_connections" {
  source   = "./modules/networking/virtual_hub_er_gateway_connection"
  for_each = try(local.networking.virtual_hub_er_gateway_connections, {})

  client_config            = local.client_config
  location                 = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name      = local.resource_groups[each.value.resource_group_key].name
  settings                 = each.value
  virtual_hub_id           = local.combined_objects_virtual_wans[try(each.value.vhub.lz_key, local.client_config.landingzone_key)][each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].id
  virtual_hub_route_tables = local.combined_objects_virtual_hub_route_tables

  virtual_network_gateway_id = coalesce(
    try(local.combined_objects_virtual_wans[try(each.value.vhub.lz_key, local.client_config.landingzone_key)][each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].er_gateway.id, null),
    try(each.value.express_route_gateway_id, null)
  )

  express_route_gateway_name = coalesce(
    try(local.combined_objects_virtual_wans[try(each.value.vhub.lz_key, local.client_config.landingzone_key)][each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].er_gateway.name, null),
    try(each.value.express_route_gateway_name, null)
  )

  express_route_circuit_id = try(coalesce(
    try(module.express_route_circuits[each.value.express_route_circuit.key].id, null),
    try(var.remote_objects.express_route_circuits[try(each.value.express_route_circuit.lz_key, local.client_config.landingzone_key)][each.value.express_route_circuit.key].id, null),
    try(each.value.express_route_circuit.id, null)
    ),
    null
  )

  authorization_key = try(
    coalesce(
      try(module.express_route_circuit_authorizations[each.value.express_route_circuit_authorization.key].authorization_key, null),
      try(each.value.express_route_circuit_authorization.authorization_key, null)
    ),
    null
  )


}