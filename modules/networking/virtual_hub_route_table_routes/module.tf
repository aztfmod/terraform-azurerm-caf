resource "azurerm_virtual_hub_route_table_route" "vhrtr" {
  destinations      = var.settings.destinations
  destinations_type = var.settings.destinations_type
  name              = var.settings.name
  next_hop_type     = try(var.settings.next_hop_type, null)
  route_table_id    = var.route_table_id

  next_hop = can(var.settings.next_hop.id) ? var.settings.next_hop.id : var.remote_objects[var.settings.next_hop.resource_type][try(var.settings.next_hop.lz_key, var.client_config.landingzone_key)][var.settings.next_hop.key].id
}