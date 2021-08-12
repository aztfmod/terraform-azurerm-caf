
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

  name = each.value.name

  virtual_hub_id = coalesce(
    try(local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].id, null),
    try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].id, null),
    try(local.combined_objects_virtual_wans[try(each.value.vhub.lz_key, local.client_config.landingzone_key)][each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].id, null),
    try(each.value.virtual_hub.id, null),
    try(each.value.virtual_hub_id, null)
  )

  # Managed by the module.azurerm_virtual_hub_route_table
  lifecycle {
    ignore_changes = [
      labels,
      route,
      virtual_hub_id
    ]
  }

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
  for_each   = local.networking.virtual_hub_route_tables

  client_config = local.client_config
  name          = each.value.name
  settings      = each.value

  remote_objects = {
    virtual_hub_connections = local.combined_objects_virtual_hub_connections
    azurerm_firewalls       = local.combined_objects_azurerm_firewalls
  }

  virtual_hub = {
    id = coalesce(
      try(local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].id, null),
      try(local.combined_objects_virtual_wans[try(each.value.vhub.lz_key, local.client_config.landingzone_key)][each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].id, null),
      try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].id, null),
      try(each.value.virtual_hub.id, null),
      try(each.value.virtual_hub_id, null)
    )
    name = coalesce(
      try(local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].name, null),
      try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].name, null),
      try(each.value.virtual_hub.name, null)
    )
    resource_group_name = coalesce(
      try(local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].resource_group_name, null),
      try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].resource_group_name, null),
      try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
      try(each.value.virtual_hub.resource_group_name, "")
    )
  }

  resource_ids = {
    #
    # Removing support for vhub connection in route table to prevent circula references
    # Interim support - Adding only remote virtual_hub_connections. route tables must be deployed in a different tfstate
    #
    virtual_hub_connection = try(var.remote_objects.virtual_hub_connections, {})
  }
}