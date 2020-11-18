#
#
# Express Route Circuits
#
#

module express_route_circuits {
  source   = "./modules/networking/express_route_circuit"
  for_each = local.networking.express_route_circuits

  settings            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  resource_groups     = module.resource_groups
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics         = local.diagnostics
  global_settings     = local.global_settings
}

#
#
# Express Route Circuit Authorization
#
#

module express_route_circuit_authorizations {
  source   = "./modules/networking/express_route_circuit_authorization"
  for_each = local.networking.express_route_circuit_authorizations

  settings                   = each.value
  resource_group_name        = module.express_route_circuits[each.value.express_route_key].resource_group_name
  express_route_circuit_name = module.express_route_circuits[each.value.express_route_key].name
}


# Outputs
output express_route_circuits {
  value       = module.express_route_circuits
  sensitive   = false
  description = "Express Route Circuit output"
}

output express_route_circuit_authorizations {
  value       = module.express_route_circuit_authorizations
  sensitive   = false
  description = "Express Route Circuit Authorizations Keys output"
}
