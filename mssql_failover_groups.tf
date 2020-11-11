module "mssql_failover_groups" {
  source   = "./modules/databases/mssql_failover_group"
  for_each = local.database.mssql_failover_groups

  global_settings       = local.global_settings
  client_config         = local.client_config
  settings              = each.value
  resource_group_name   = module.resource_groups[each.value.resource_group_key].name
  primary_server_name   = try(each.value.managed_instance, false) == false ? local.combined_objects_mssql_servers[try(each.value.primary_server.lz_key, local.client_config.landingzone_key)][each.value.primary_server.key].name : local.combined_objects_mssql_managed_instances[try(each.value.primary_server.lz_key, local.client_config.landingzone_key)][each.value.primary_server.key].name
  secondary_server_id   = try(each.value.managed_instance, false) == false ? local.combined_objects_mssql_servers[try(each.value.secondary_server.lz_key, local.client_config.landingzone_key)][each.value.secondary_server.key].id : local.combined_objects_mssql_managed_instances[try(each.value.secondary_server.lz_key, local.client_config.landingzone_key)][each.value.secondary_server.key].id
  databases             = try(each.value.managed_instance, false) == false ? local.combined_objects_mssql_databases : local.combined_objects_mssql_managed_databases
  base_tags             = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}
