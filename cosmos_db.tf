module cosmos_db {
  source   = "./modules/databases/cosmos_db"
  for_each = local.database.cosmos_db

  location                = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name     = module.resource_groups[each.value.resource_group_key].name
  global_settings         = local.global_settings
  settings                = each.value
  base_tags               = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output cosmos_db {
  value     = module.cosmos_db
  sensitive = true
}

