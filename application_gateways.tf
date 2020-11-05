module application_gateways {
  source   = "./modules/networking/application_gateway"
  for_each = local.networking.application_gateways

  global_settings     = local.global_settings
  client_config       = local.client_config
  diagnostics         = local.diagnostics
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  settings            = each.value
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier
  vnets               = local.combined_objects_networking
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
<<<<<<< HEAD
  private_dns         = lookup(each.value, "private_dns_records", null) == null ? {} : local.combined_objects_private_dns
  public_ip_addresses = local.combined_objects_public_ip_addresses
  app_services        = local.combined_objects_app_services
=======
  public_ip_addresses = local.combined_objects_public_ip_addresses
>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef
  application_gateway_applications = {
    for key, value in local.networking.application_gateway_applications : key => value
    if value.application_gateway_key == each.key
  }
}

output application_gateways {
  value     = module.application_gateways
  sensitive = true
}

output application_gateway_applications {
  value     = local.networking.application_gateway_applications
  sensitive = true
}
