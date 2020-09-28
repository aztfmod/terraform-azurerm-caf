module application_gateways {
  source   = "./modules/networking/application_gateway"
  for_each = local.networking.application_gateways

  global_settings                  = local.global_settings
  diagnostics                      = local.diagnostics
  resource_group_name              = module.resource_groups[each.value.resource_group_key].name
  location                         = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  settings                         = each.value
  sku_name                         = each.value.sku_name
  sku_tier                         = each.value.sku_tier
  vnets                            = module.networking
  public_ip_addresses              = module.public_ip_addresses
  application_gateway_applications = local.networking.application_gateway_applications[each.key]
}

output application_gateways {
  value       = module.application_gateways
  sensitive   = true
}

output application_gateway_applications {
  value       = local.networking.application_gateway_applications
  sensitive   = true
}
