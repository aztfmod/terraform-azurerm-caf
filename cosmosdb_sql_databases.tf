output "cosmosdb_sql_databases" {
  value = module.cosmosdb_sql_databases
}

module "cosmosdb_sql_databases" {
  source   = "./modules/databases/cosmos_dbs/sql_database"
  for_each = local.database.cosmosdb_sql_databases

  global_settings       = local.global_settings
  settings              = each.value
  resource_group_name   = coalesce(
    try(local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmosdb_account_key].resource_group_name, null),
    try(local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmosdb_account_key].resource_group_name, null)
  )
  location              = coalesce(
    try(local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmosdb_account_key].location, null),
    try(local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmosdb_account_key].location, null)
  )
  cosmosdb_account_name = coalesce(
    try(local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmosdb_account_key].name, null),
    try(local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmosdb_account_key].name, null)
  )
}
