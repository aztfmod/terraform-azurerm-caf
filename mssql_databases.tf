output mssql_databases {
  value = module.mssql_databases

}

module "mssql_databases" {
  source   = "./modules/databases/mssql_database"
  for_each = local.database.mssql_databases

  global_settings      = local.global_settings
  managed_identities   = local.combined_objects_managed_identities
  settings             = each.value
  server_id            = try(local.combined_objects_mssql_servers[local.client_config.landingzone_key][each.value.mssql_server_key].id, local.combined_objects_mssql_servers[each.value.lz_key][each.value.mssql_server_key].id)
  server_name          = try(local.combined_objects_mssql_servers[local.client_config.landingzone_key][each.value.mssql_server_key].name, local.combined_objects_mssql_servers[each.value.lz_key][each.value.mssql_server_key].name)
  elastic_pool_id      = try(each.value.elastic_pool_key, null) == null ? null : try(local.combined_objects_mssql_elastic_pools[local.client_config.landingzone_key][each.value.elastic_pool_key].id, local.combined_objects_mssql_elastic_pools[each.value.lz_key][each.value.elastic_pool_key].id)
  storage_accounts     = module.storage_accounts
  base_tags            = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}
