
output mssql_elastic_pools {
  value     = module.mssql_elastic_pools
  sensitive = true
}

module "mssql_elastic_pools" {
  source   = "./modules/databases/mssql_elastic_pool"
  for_each = local.database.mssql_elastic_pools

  global_settings = local.global_settings
  settings        = each.value
  base_tags       = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  server          = try(each.value.elastic_pool_key, null) == null ? null : try(local.combined_objects_mssql_servers[local.client_config.landingzone_key][each.value.mssql_server_key], local.combined_objects_mssql_servers[each.value.lz_key][each.value.mssql_server_key])
}
