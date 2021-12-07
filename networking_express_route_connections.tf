module "express_route_connections" {
  source   = "./modules/networking/express_route_connection"
  for_each = try(local.networking.express_route_connections, {})

  client_config            = local.client_config
  settings                 = each.value
  virtual_hub_route_tables = local.combined_objects_virtual_hub_route_tables

  virtual_hub_id = coalesce(
    try(local.combined_objects_virtual_hubs[each.value.virtual_hub.lz_key][each.value.virtual_hub.key].id, null),
    try(local.combined_objects_virtual_hubs[local.client_config.landingzone_key][each.value.virtual_hub.key].id, null),
    try(each.value.virtual_hub.id, null),
    try(each.value.virtual_hub_id, null)
  )

  express_route_circuit_peering_id = coalesce(
    try(local.combined_objects_express_route_circuit_peerings[each.value.circuit_peering.lz_key][each.value.circuit_peering.key].id, null),
    try(each.value.express_route_circuit_peering_id, null)
  )

  express_route_gateway_id = coalesce(
    try(local.combined_objects_virtual_hubs[each.value.virtual_hub.lz_key][each.value.virtual_hub.key].er_gateway.id, null),
    try(local.combined_objects_virtual_hubs[local.client_config.landingzone_key][each.value.virtual_hub.key].er_gateway.id, null),
    try(each.value.express_route_gateway_id, null)
  )

  authorization_key = try(
    coalesce(
      try(local.combined_objects_express_route_circuit_authorizations[each.value.express_route_circuit_authorization.lz_key][each.value.express_route_circuit_authorization.key].authorization_key, null),
      try(each.value.authorization_key, null)
    ),
    null
  )

}