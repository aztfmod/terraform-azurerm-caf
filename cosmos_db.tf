module cosmos_dbs {
  source   = "./modules/databases/cosmos_dbs"
  for_each = local.database.cosmos_dbs

  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output cosmos_dbs {
  value     = module.cosmos_dbs
  sensitive = true
}