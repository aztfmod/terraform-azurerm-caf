
output mariadb_databases {
  value     = module.mariadb_databases
  sensitive = true
}

module "mariadb_databases" {
  source   = "./modules/databases/mariadb_server"
  for_each = local.database.mariadb_databases

  global_settings  = local.global_settings
  settings         = each.value
  server_id        = try(local.combined_objects_mssql_servers[local.client_config.landingzone_key][each.value.mssql_server_key].id, local.combined_objects_mssql_servers[each.value.lz_key][each.value.mssql_server_key].id)
  storage_accounts = module.storage_accounts
  base_tags        = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}