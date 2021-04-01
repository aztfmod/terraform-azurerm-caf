locals {
  arm_filename = "${path.module}/arm_vhub_er_connection.json"

  template_content = templatefile(
    local.arm_filename,
    {
      resource_name                    = format("%s/%s", local.express_route_gateway_name, local.express_route_connection_name)
      express_route_circuit_peering_id = local.express_route_circuit_peering_id
      authorization_key                = local.authorization_key
      routing_weight                   = local.routing_weight
      enable_internet_security         = local.enable_internet_security
      routingConfiguration = jsonencode(
        {
          associatedRouteTable  = local.associated_route_table
          propagatedRouteTables = local.propagated_route_tables
          vnetRoutes            = local.vnet_routes
        }
      )
      
    }
  )


  express_route_gateway_name       = var.express_route_gateway_name
  express_route_connection_name    = var.settings.name
  express_route_circuit_peering_id = format("%s/peerings/AzurePrivatePeering", var.express_route_circuit_id)
  authorization_key                = var.authorization_key
  routing_weight                   = try(var.settings.routing_weight, 0)
  enable_internet_security         = try(var.settings.enable_internet_security, false)

  associated_route_table =  try({
      id = coalesce(
        try(var.settings.route_table.id, ""),
        try(var.virtual_hub_route_tables[try(var.settings.route_table.lz_key, var.client_config.landingzone_key)][var.settings.route_table.key].id, "")
      )
    },null)

  propagated_route_tables = {
    Labels = try(var.settings.propagated_route_tables.labels, [])
    Ids = coalescelist(
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
          }
        ]
      ),
      []
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

resource "azurerm_resource_group_template_deployment" "vhub_er_gw_connection" {
  name                = local.express_route_connection_name
  resource_group_name = var.resource_group_name
  lifecycle {
    ignore_changes = [
      name
    ]
  }
  template_content = local.template_content
  deployment_mode  = "Incremental"
}
