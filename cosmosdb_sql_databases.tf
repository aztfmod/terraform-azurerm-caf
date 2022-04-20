output "cosmosdb_sql_databases" {
  value = module.cosmosdb_sql_databases
}

module "cosmosdb_sql_databases" {
  source   = "./modules/databases/cosmos_dbs/sql_database"
  for_each = local.database.cosmosdb_sql_databases

  global_settings = local.global_settings
  settings        = each.value

  resource_group_name   = can(each.value.cosmosdb_account.rg_name) ? each.value.cosmosdb_account.rg_name : local.combined_objects_cosmos_dbs[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.cosmosdb_account.key, each.value.cosmosdb_account_key)].resource_group_name
  location              = can(each.value.cosmosdb_account.location) ? each.value.cosmosdb_account.location : local.combined_objects_cosmos_dbs[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.cosmosdb_account.key, each.value.cosmosdb_account_key)].location
  cosmosdb_account_name = can(each.value.cosmosdb_account.name) ? each.value.cosmosdb_account.name : local.combined_objects_cosmos_dbs[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.cosmosdb_account.key, each.value.cosmosdb_account_key)].name
}
