module "mssql_failover_groups" {
  source   = "./modules/databases/mssql_failover_group"
  for_each = local.database.mssql_failover_groups

  global_settings       = local.global_settings
  client_config         = local.client_config
  settings              = each.value
  resource_group_name   = module.resource_groups[each.value.resource_group_key].name
  primary_server_name   = local.combined_objects_mssql_servers[try(each.value.primary_server.lz_key, local.client_config.landingzone_key)][each.value.primary_server.sql_server_key].name
  secondary_server_id   = local.combined_objects_mssql_servers[try(each.value.secondary_server.lz_key, local.client_config.landingzone_key)][each.value.secondary_server.sql_server_key].id
  databases             = local.combined_objects_mssql_databases
  base_tags             = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}
