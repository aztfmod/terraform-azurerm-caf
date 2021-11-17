#
#
# Express Route Circuits
#
#

module "express_route_circuits" {
  source   = "./modules/networking/express_route_circuit"
  for_each = local.networking.express_route_circuits

  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  resource_groups     = local.resource_groups
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
}

#
#
# Express Route Circuit Authorization
#
#

module "express_route_circuit_authorizations" {
  source   = "./modules/networking/express_route_circuit_authorization"
  for_each = local.networking.express_route_circuit_authorizations

  settings            = each.value
  resource_group_name = try(local.resource_groups[each.value.resource_group_key].name, null) == null ? module.express_route_circuits[each.value.express_route_key].resource_group_name : local.resource_groups[each.value.resource_group_key].name
  express_route_circuit_name = coalesce(
    try(local.combined_objects_express_route_circuits[each.value.lz_key][each.value.express_route_key].name, null),
    try(local.combined_objects_express_route_circuits[local.client_config.landingzone_key][each.value.express_route_key].name, null)
  )
}

#
#
# Express Route Circuit Peering
#
#

module "express_route_circuit_peerings" {
  source   = "./modules/networking/express_route_circuit_peering"
  for_each = local.networking.express_route_circuit_peerings

  settings = each.value

  resource_group_name = coalesce(
    try(local.combined_objects_express_route_circuits[each.value.express_route.lz_key][each.value.express_route.key].resource_group_name, null),
    try(local.combined_objects_express_route_circuits[local.client_config.landingzone_key][each.value.express_route_key].resource_group_name, null)
  )
  express_route_circuit_name = coalesce(
    try(local.combined_objects_express_route_circuits[each.value.express_route.lz_key][each.value.express_route.key].name, null),
    try(local.combined_objects_express_route_circuits[local.client_config.landingzone_key][each.value.express_route_key].name, null)
  )
}

# Outputs
output "express_route_circuits" {
  value       = module.express_route_circuits
  sensitive   = true
  description = "Express Route Circuit output"
}

output "express_route_circuit_authorizations" {
  value       = module.express_route_circuit_authorizations
  sensitive   = true
  description = "Express Route Circuit Authorizations Keys output"
}

output "express_route_circuit_peerings" {
  value       = module.express_route_circuit_peerings
  sensitive   = true
  description = "Express Route Circuit Peerings output"
}
