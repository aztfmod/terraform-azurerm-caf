module "mssql_mi_failover_groups" {
  source   = "./modules/databases/mssql_mi_failover_group"
  for_each = local.database.mssql_mi_failover_groups

  global_settings           = local.global_settings
  settings                  = each.value
  resource_group_name       = module.resource_groups[each.value.resource_group_key].name
  primaryManagedInstanceId  = local.combined_objects_mssql_managed_instances[try(each.value.primary_server.lz_key, local.client_config.landingzone_key)][each.value.primary_server.mi_server_key].id
  partnerManagedInstanceId  = local.combined_objects_mssql_managed_instances[try(each.value.secondary_server.lz_key, local.client_config.landingzone_key)][each.value.secondary_server.mi_server_key].id
  partnerRegion             = local.combined_objects_mssql_managed_instances[try(each.value.secondary_server.lz_key, local.client_config.landingzone_key)][each.value.secondary_server.mi_server_key].location
  base_tags                 = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}
