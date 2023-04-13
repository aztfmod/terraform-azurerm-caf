
output "mssql_managed_databases" {
  value = merge(module.mssql_managed_databases, module.mssql_managed_databases_v1)

}


module "mssql_managed_databases_v1" {
  source = "./modules/databases/mssql_managed_database_v1"
  for_each = {
    for key, value in local.database.mssql_managed_databases : key => value
    if try(value.version, "") == "v1"
  }
  global_settings = local.global_settings
  settings        = each.value
  server_id       = can(each.value.server_id) ? each.value.server_id : local.combined_objects_mssql_managed_instances[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.mi_server_key].id
}


module "mssql_managed_databases_restore_v1" {
  source = "./modules/databases/mssql_managed_database_restore_v1"
  for_each = {
    for key, value in local.database.mssql_managed_databases_restore : key => value
    if try(value.version, "") == "v1"
  }
  base_tags          = local.global_settings.inherit_tags
  global_settings    = local.global_settings
  settings           = each.value
  source_database_id = try(each.value.properties.create_mode, null) == "PointInTimeRestore" ? can(each.value.properties.source_database.id) ? each.value.properties.source_database.id : local.combined_objects_mssql_managed_databases[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.properties.source_database.database_key].id : null
  server_id          = can(each.value.server_id) ? each.value.server_id : local.combined_objects_mssql_managed_instances[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.mi_server_key].id
  server_location    = can(each.value.server_id) ? each.value.server_location : local.combined_objects_mssql_managed_instances[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.mi_server_key].location
  server_tags        = can(each.value.server_id) ? try(each.value.server_tags, null) : try(local.combined_objects_mssql_managed_instances[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.mi_server_key].tags, null)
}
