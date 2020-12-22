module dns_zones {
  source   = "./modules/networking/dns_zone"
  for_each = try(local.networking.dns_zones, {})

  settings            = each.value
  global_settings     = local.global_settings
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}


