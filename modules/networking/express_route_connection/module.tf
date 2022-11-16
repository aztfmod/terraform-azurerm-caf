resource "azurerm_express_route_connection" "erc" {
  name                             = var.settings.name
  express_route_gateway_id         = var.express_route_gateway_id
  express_route_circuit_peering_id = var.express_route_circuit_peering_id

  # Optional
  authorization_key        = var.authorization_key
  enable_internet_security = try(var.settings.enable_internet_security, null)
  routing_weight           = try(var.settings.routing_weight, null)

  dynamic "routing" {
    for_each = can(var.settings.routing) ? [1] : []

    content {
      associated_route_table_id = local.associated_route_table

      dynamic "propagated_route_table" {
        for_each = can(var.settings.routing.propagated_route_table) ? [1] : []

        content {
          labels = try(var.settings.routing.propagated_route_table.labels, null)

          route_table_ids = local.propagated_route_tables.Ids
        }
      }
    }
  }

}

locals {
  associated_route_table = {
    id = try(coalesce(
      try(var.virtual_hub_route_tables[var.settings.route_table.lz_key][var.settings.route_table.key].id, ""),
      try(var.virtual_hub_route_tables[var.client_config.landingzone_key][var.settings.route_table.key].id, ""),
      try(var.settings.route_table.id, ""),
      contains(tolist(["defaultRouteTable", "noneRouteTable"]), try(var.settings.route_table.key, "")) ? format("%s/hubRouteTables/%s", var.virtual_hub_id, var.settings.route_table.key) : ""
    ), null)
  }

  propagated_route_tables = {
    Ids = flatten(
      [
        flatten(
          [
            for key in try(var.settings.propagated_route_tables.ids, []) : {
              Id = key
            }
          ]
        ),
        flatten(
          [
            for key in try(var.settings.propagated_route_tables.keys, []) : {
              Id = var.virtual_hub_route_tables[try(var.settings.propagated_route_tables.lz_key, var.client_config.landingzone_key)][key].id
            } if contains(tolist(["defaultRouteTable", "noneRouteTable"]), key) == false
          ]
        ),
        flatten(
          [
            for key in try(var.settings.propagated_route_tables.keys, []) : {
              Id = format("%s/hubRouteTables/%s", var.virtual_hub_id, key)
            } if contains(tolist(["defaultRouteTable", "noneRouteTable"]), key) == true
          ]
        )
      ]
    )
  }
}