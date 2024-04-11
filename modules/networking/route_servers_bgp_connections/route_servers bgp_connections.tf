resource "azurerm_route_server_bgp_connection" "ars_bgp_connection" {

  name            = var.settings.name
  peer_asn        = var.settings.peer_asn
  peer_ip         = var.settings.peer_ip
  route_server_id = can(var.settings.route_server_id) ? var.settings.route_server_id : can(var.settings.route_server.key) ? var.remote_objects.lb[try(var.settings.route_server.lz_key, var.client_config.landingzone_key)][var.settings.route_server.key].id : null
}
