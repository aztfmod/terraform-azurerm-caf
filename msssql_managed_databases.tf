
output mssql_managed_databases {
  value     = module.mssql_managed_databases
  sensitive = true
}

module "mssql_managed_databases" {
  source     = "./modules/databases/mssql_managed_database"
  for_each   = local.database.mssql_managed_databases

  global_settings     = local.global_settings
  settings            = each.value
  server_name         = local.combined_objects_mssql_managed_instances[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.mi_server_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}