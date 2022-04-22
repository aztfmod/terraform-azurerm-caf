# virtual_hub_route_table_routes = {
#   all_traffic = {
#     route_table = {
#       name = "defaultRouteTable"
#     }
#     virtual_hub = {

#     }
#     # to route to the secure firewall name must be aither 'all_traffic', 'private_traffic', 'public_traffic'
#     name = "all_traffic"
#     destinations_type = "CIDR"
#     destinations = ["0.0.0.0/0","10.0.0.0/8","172.16.0.0/12","192.168.0.0/16"]
#     next_hop_type = "ResourceId"
#     next_hop = {
#       lz_key = ""
#       resource_type = ""
#       key = ""
#       # or
#       id = ""
#     }
#   }
# }


module "azurerm_virtual_hub_route_table_route" {
  depends_on = [module.azurerm_virtual_hub_route_table]
  source     = "./modules/networking/virtual_hub_route_table_routes"
  for_each   = local.networking.virtual_hub_route_table_routes

  client_config = local.client_config
  settings      = each.value

  remote_objects = {
    azurerm_firewall = local.combined_objects_azurerm_firewalls
  }

  route_table_id = can(each.value.route_table.name) || can(each.value.route_table.id) ? try(each.value.route_table.id, format("%s/hubRouteTables/%s", local.combined_objects_virtual_hubs[try(each.value.virtual_hub.lz_key, local.client_config.landingzone_key)][each.value.virtual_hub.key].id, each.value.route_table.name)) : format("%s/hubRouteTables/%s", local.combined_objects_virtual_hub_route_tables[try(each.value.route_table.lz_key, local.client_config.landingzone_key)][each.value.route_table.key].id)

}