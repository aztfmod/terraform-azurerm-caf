
#
#
# Virtual WAN peerings with vnets
#
#

output "azurerm_virtual_hub_connection" {
  value = azurerm_virtual_hub_connection.vhub_connection
}

output "azurerm_virtual_hub_route_table" {
  value = azurerm_virtual_hub_route_table.route_table
}



# Virtual Hub Peerings to virtual networks
resource "azurerm_virtual_hub_connection" "vhub_connection" {
  depends_on = [azurerm_virtual_hub_route_table.route_table]
  for_each   = local.networking.virtual_hub_connections

  name                      = each.value.name
  virtual_hub_id            = local.combined_objects_virtual_wans[try(each.value.vhub.lz_key, local.client_config.landingzone_key)][each.value.vhub.virtual_wan_key].virtual_hubs[each.value.vhub.virtual_hub_key].id
  remote_virtual_network_id = local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.vnet_key].id
  internet_security_enabled = try(each.value.internet_security_enabled, null)

  dynamic "routing" {
    for_each = try(each.value.routing, {})

    content {
      associated_route_table_id = try(
        coalesce(
          try(routing.value.id, ""),
          try(azurerm_virtual_hub_route_table.route_table[routing.value.virtual_hub_route_table_key].id, ""),
          try(var.remote_objects.virtual_hub_route_tables[try(routing.value.lz_key, local.client_config.landingzone_key)][routing.value.virtual_hub_route_table_key].id, "")
        ),
        null
      )

      dynamic "propagated_route_table" {
        for_each = try(routing.value.propagated_route_table, null) == null ? [] : [1]

        content {
          labels = try(propagated_route_table.value.labels, null)
          route_table_ids = coalesce(
            flatten(
              [
                for key in try(routing.value.propagated_route_table.virtual_hub_route_table_keys, []) : azurerm_virtual_hub_route_table.route_table[key].id
              ]
            ),
            flatten(
              [
                for key in try(routing.value.propagated_route_table.keys, []) : var.remote_objects.virtual_hub_route_tables[try(routing.value.propagated_route_table.value.lz_key, local.client_config.landingzone_key)][key].id
              ]
            ),
            flatten(
              [
                for id in try(routing.value.propagated_route_table.ids, []) : id
              ]
            )
          )
        }
      }

      dynamic "static_vnet_route" {
        for_each = try(routing.value.static_vnet_route, {})

        content {
          name                = static_vnet_route.value.name
          address_prefixes    = static_vnet_route.value.address_prefixes
          next_hop_ip_address = static_vnet_route.value.next_hop_ip_address
        }
      }

    }
  }
}

resource "azurerm_virtual_hub_route_table" "route_table" {
  for_each = local.networking.virtual_hub_route_tables

  name   = each.value.name
  labels = each.value.labels

  virtual_hub_id = coalesce(
    try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].id, ""),
    try(each.value.virtual_hub_id, "")
  )

  lifecycle {
    ignore_changes = [
      route
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
  depends_on = [azurerm_virtual_hub_connection.vhub_connection, azurerm_virtual_hub_route_table.route_table]
  source     = "./modules/networking/virtual_hub_route_tables"
  for_each = {
    for key, value in local.networking.virtual_hub_route_tables : key => value
    if try(value.routes, null) != null
  }

  client_config = local.client_config
  name          = each.value.name
  settings      = each.value

  virtual_hub_id = coalesce(
    try(local.combined_objects_virtual_wans[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.virtual_wan_key].virtual_hubs[each.value.virtual_hub_key].id, ""),
    try(each.value.virtual_hub_id, "")
  )

  resource_ids = {
    virtual_hub_connection = local.combined_objects_virtual_hub_connections
    azurerm_firewall       = local.combined_objects_azurerm_firewalls
  }
}