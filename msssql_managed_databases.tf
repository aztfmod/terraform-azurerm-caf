
output "mssql_managed_databases" {
  value = module.mssql_managed_databases

}

module "mssql_managed_databases" {
  source   = "./modules/databases/mssql_managed_database"
  for_each = local.database.mssql_managed_databases

  global_settings     = local.global_settings
  settings            = each.value
  server_name         = can(each.value.server_name) ? each.value.server_name : local.combined_objects_mssql_managed_instances[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.mi_server_key].name
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
}

module "mssql_managed_databases_restore" {
  source   = "./modules/databases/mssql_managed_database"
  for_each = local.database.mssql_managed_databases_restore

  global_settings     = local.global_settings
  settings            = each.value
  server_name         = can(each.value.server_name) ? each.value.server_name : local.combined_objects_mssql_managed_instances[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.mi_server_key].name
  sourceDatabaseId    = try(each.value.createMode, null) == "PointInTimeRestore" ? module.mssql_managed_databases[each.value.source_database_key].id : ""
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
}

module "mssql_managed_databases_backup_ltr" {
  source   = "./modules/databases/mssql_managed_database/backup_ltr"
  for_each = local.database.mssql_managed_databases_backup_ltr

  settings            = each.value
  server_name         = can(each.value.server_name) ? each.value.server_name : local.combined_objects_mssql_managed_instances[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.mi_server_key].name
  db_name             = try(module.mssql_managed_databases[each.value.database_key].name, module.mssql_managed_databases_restore[each.value.database_key].name)
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
}