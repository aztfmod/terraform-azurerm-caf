module cosmos_dbs {
  source   = "./modules/databases/cosmos_dbs"
  for_each = local.database.cosmos_dbs

  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

<<<<<<< HEAD
output cosmos_dbs {
  value     = module.cosmos_dbs
  sensitive = true
=======
output cosmos_db_id {
  value     = module.cosmos_db
  
>>>>>>> 46dfc77c632a31f1351a4087c7a0efb62e509361
}