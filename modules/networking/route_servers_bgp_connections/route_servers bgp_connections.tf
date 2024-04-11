resource "azurerm_route_server_bgp_connection" "ars_bgp_connection" {

  name            = var.settings.name
  peer_asn        = var.settings.peer_asn
  peer_ip         = var.settings.peer_ip
  route_server_id = try(var.settings.route_server_id, null) != null ? var.settings.route_server_id : (lookup(var.settings.route_server, "lz_key", null) == null ? var.route_servers[var.client_config.landingzone_key][var.settings.route_server.route_server_key].id : var.route_servers[var.settings.route_server.lz_key][var.settings.route_server.route_server_key].id)

}
