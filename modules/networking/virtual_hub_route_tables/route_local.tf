locals {
  routes = flatten(
    [
      for route, value in try(var.settings.routes, []) : {
        name            = value.name
        destinationType = try(upper(value.destinations_type), "CIDR")
        destinations    = value.destinations
        nextHopType     = "ResourceId"
        nextHop = coalesce(
          try(value.next_hop_id, ""),
          try(var.remote_objects.virtual_hub_connections[value.next_hop.lz_key][value.next_hop.key].id, ""),
          try(var.remote_objects.azurerm_firewalls[value.next_hop.lz_key][value.next_hop.key].id, ""),
          try(var.resource_ids[value.next_hop.resource_type][value.next_hop.lz_key][value.next_hop.key].id, "") # Note the virtual_hub_connection must come from a remote tfstate only. PB with circular reference in the object model of vhub tables and connections
        )
      }
    ]
  )
}