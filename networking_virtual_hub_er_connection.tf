#
# Original implementation - Only support AzurePrivatePeering
# Prefer the express_route_connections (networking_express_route_connections.tf)
#
module "virtual_hub_er_gateway_connections" {
  source   = "./modules/networking/virtual_hub_er_gateway_connection"
  for_each = try(local.networking.virtual_hub_er_gateway_connections, {})

  client_config            = local.client_config
  settings                 = each.value
  virtual_hub_route_tables = local.combined_objects_virtual_hub_route_tables


  virtual_hub_id = coalesce(
    try(local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].id, null),
    try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].id, null),
    try(local.combined_objects_virtual_wans[try(each.value.vhub.lz_key, local.client_config.landingzone_key)][each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].id, null),
    try(each.value.virtual_hub.id, null),
    try(each.value.virtual_hub_id, null)
  )

  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  virtual_network_gateway_id = coalesce(
    try(local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].er_gateway.id, null),
    try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].er_gateway.id, null),
    try(local.combined_objects_virtual_wans[try(each.value.vhub.lz_key, local.client_config.landingzone_key)][each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].er_gateway.id, null),
    try(each.value.express_route_gateway.id, null),
    try(each.value.express_route_gateway_id, null)
  )

  express_route_gateway_name = coalesce(
    try(local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].er_gateway.name, null),
    try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].er_gateway.name, null),
    try(local.combined_objects_virtual_wans[try(each.value.vhub.lz_key, local.client_config.landingzone_key)][each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].er_gateway.name, null),
    try(each.value.express_route_gateway.name, null),
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