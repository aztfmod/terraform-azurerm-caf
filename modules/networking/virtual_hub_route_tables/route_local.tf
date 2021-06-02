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
          try(var.resource_ids[value.next_hop.resource_type][try(value.next_hop.lz_key, var.client_config.landingzone_key)][value.next_hop.resource_key].id, "")
        )
      }
    ]
  )
}