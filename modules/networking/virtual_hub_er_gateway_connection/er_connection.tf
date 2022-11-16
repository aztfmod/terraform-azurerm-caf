resource "azurerm_resource_group_template_deployment" "vhub_er_gw_connection" {
  name                = local.express_route_connection_name
  resource_group_name = var.resource_group_name
  lifecycle {
    ignore_changes = [
      name
    ]
  }
  template_content   = file(local.arm_filename)
  parameters_content = local.parameters_content
  deployment_mode    = "Incremental"
}

locals {
  arm_filename = "${path.module}/arm_vhub_er_connection.json"

  parameters_content = jsonencode(
    {
      resource_name = {
        value = format("%s/%s", local.express_route_gateway_name, local.express_route_connection_name)
      }
      express_route_circuit_peering_id = {
        value = local.express_route_circuit_peering_id
      }
      authorization_key = {
        value = local.authorization_key
      }
      routing_weight = {
        value = local.routing_weight
      }
      enable_internet_security = {
        value = local.enable_internet_security
      }
      associatedRouteTable = {
        value = local.associated_route_table
      }
      propagatedRouteTables = {
        value = local.propagated_route_tables
      }
      vnetRoutes = {
        value = local.vnet_routes
      }
    }
  )


  express_route_gateway_name       = var.express_route_gateway_name
  express_route_connection_name    = var.settings.name
  express_route_circuit_peering_id = format("%s/peerings/AzurePrivatePeering", var.express_route_circuit_id)
  authorization_key                = var.authorization_key
  routing_weight                   = try(var.settings.routing_weight, 0)
  enable_internet_security         = try(var.settings.enable_internet_security, false)

  associated_route_table = {
    id = coalesce(
      try(var.settings.route_table.id, ""),
      try(var.virtual_hub_route_tables[try(var.settings.route_table.lz_key, var.client_config.landingzone_key)][var.settings.route_table.key].id, ""),
      contains(tolist(["defaultRouteTable", "noneRouteTable"]), try(var.settings.route_table.key, "")) ? format("%s/hubRouteTables/%s", var.virtual_hub_id, var.settings.route_table.key) : ""
    )
  }

  propagated_route_tables = {
    Labels = try(var.settings.propagated_route_tables.labels, [])
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

  vnet_routes = {
    staticRoutes = flatten(
      [
        for key, value in try(var.settings.vnet_routes, []) : {
          name             = value.name
          addressPrefixes  = value.address_prefixes
          nextHopIpAddress = value.next_hop_ip_address
        }
      ]
    )
  }

}
