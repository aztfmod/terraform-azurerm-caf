# locals {
#   routes = flatten(
#     [
#       for route, value in try(var.settings.routes, []) : {
#         name            = value.name
#         destinationType = try(upper(value.destinations_type), "CIDR")
#         destinations    = value.destinations
#         nextHopType     = "ResourceId"
#         nextHop = coalesce(
#           try(value.next_hop_id, ""),
#           try(var.resource_ids[value.next_hop.resource_type][try(value.next_hop.lz_key, var.client_config.landingzone_key)][value.next_hop.resource_key].id, "")
#         )
#       }
#     ]
#   )
# }


# resource "null_resource" "virtual_hub_route_table" {

#   triggers = {
#     URL = format(
#       "https://management.azure.com%s/hubRouteTables/%s?api-version=2020-11-01",
#       var.virtual_hub_id,
#       var.name
#     )
#     PROPERTIES = jsonencode(
#       {
#         properties = {
#           routes = local.routes
#           labels = try(var.settings.labels, [])
#         }
#       }
#     )
#   }

#   provisioner "local-exec" {
#     command     = format("%s/scripts/hub_route_table.sh", path.module)
#     interpreter = ["/bin/bash"]
#     on_failure  = fail

#     environment = {
#       METHOD     = "PUT"
#       PROPERTIES = self.triggers.PROPERTIES
#       URL        = self.triggers.URL
#     }
#   }

#   provisioner "local-exec" {
#     command     = format("%s/scripts/hub_route_table.sh", path.module)
#     when        = destroy
#     interpreter = ["/bin/bash"]
#     on_failure  = fail

#     environment = {
#       METHOD = "PUT"
#       URL    = self.triggers.URL
#       PROPERTIES = jsonencode(
#         {
#           properties = {
#             routes = {}
#           }
#         }
#       )
#     }
#   }
# }
