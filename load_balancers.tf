module load_balancers {
  source   = "./modules/networking/load_balancers"
  for_each = try(local.networking.load_balancers, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  public_ip_addresses = local.combined_objects_public_ip_addresses
  diagnostics         = local.combined_diagnostics
  client_config       = local.client_config
  vnets               = local.combined_objects_networking
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

