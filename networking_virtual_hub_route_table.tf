
#
#
# Virtual WAN peerings with vnets
#
#

output "virtual_hub_route_table" {
  value = azurerm_virtual_hub_route_table.route_table
}


resource "azurerm_virtual_hub_route_table" "route_table" {
  for_each = local.networking.virtual_hub_route_tables

  name   = each.value.name
  labels = try(each.value.labels, null)

  virtual_hub_id = coalesce(
    try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].id, ""),
    try(each.value.virtual_hub_id, "")
  )

  #
  # Note to prevent a circular rerefence, we need to process the dynamic route in the sub-module.
  #

  # dynamic "route" {
  #   for_each = try(each.value.route, {})

  #   content {
  #     name              = route.value.name
  #     destinations_type = route.value.destinations_type
  #     destinations      = route.value.destinations
  #     next_hop          = coalesce(
  #       try(route.value.next_hop.id, ""),
  #       try(azurerm_virtual_hub_connection.vhub_connection[route.value.next_hop.vhub_peering_key].id, ""),
  #       # try(var.remote_objects.vhub_peerings[try(each.value.next_hop.lz_key, local.client_config.landingzone_key)][route.value.next_hop.vhub_peering_key].id, "")
  #     )
  #     next_hop_type     = try(route.value.next_hop_type, "ResourceId")
  #   }
  # }
}

module "azurerm_virtual_hub_route_table" {
  depends_on = [azurerm_virtual_hub_route_table.route_table]
  source     = "./modules/networking/virtual_hub_route_tables"
  for_each = local.networking.virtual_hub_route_tables

  client_config = local.client_config
  name          = each.value.name
  settings      = each.value

  virtual_hub_id = coalesce(
    try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].id, ""),
    try(each.value.virtual_hub_id, "")
  )

  resource_ids = {
    #
    # Removing support for vhub connection in route table to prevent circula references
    #
    # virtual_hub_connection = local.combined_objects_virtual_hub_connections
    azurerm_firewall       = local.combined_objects_azurerm_firewalls
  }
}