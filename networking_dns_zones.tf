module dns_zones {
  source   = "./modules/networking/dns_zone"
  for_each = try(local.networking.dns_zones, {})

  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  client_config       = local.client_config
  global_settings     = local.global_settings
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  settings            = each.value
}

output dns_zones {
  value = module.dns_zones
}

