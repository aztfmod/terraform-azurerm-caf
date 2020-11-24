module virtual_gateways {
  source   = "./modules/networking/virtual_gateways"
  for_each = local.networking.express_route_circuits

  settings            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  resource_groups     = module.resource_groups
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics         = local.diagnostics
  global_settings     = local.global_settings
}