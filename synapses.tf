module synapse_workspaces {
  source     = "./modules/analytics/synapse"
  depends_on = [module.keyvault_access_policies]
  for_each   = local.database.synapse_workspaces

  location                             = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name                  = module.resource_groups[each.value.resource_group_key].name
  global_settings                      = local.global_settings
  settings                             = each.value
  storage_data_lake_gen2_filesystem_id = module.storage_accounts[each.value.data_lake_filesystem.storage_account_key].data_lake_filesystems[each.value.data_lake_filesystem.container_key].id
  keyvault_id                          = try(each.value.sql_administrator_login_password, null) == null ? module.keyvaults[each.value.keyvault_key].id : null
}

output synapse_workspaces {
  value     = module.synapse_workspaces
  sensitive = true
}

module synapse_sql_pool {
  source     = "./modules/analytics/synapse/addons/sql_pool"
  depends_on = [module.synapse_workspaces]
  for_each   = try(local.database.synapse_addons.synapse_sql_pool, {})

  global_settings      = local.global_settings
  settings             = each.value
  synapse_workspace_id = module.synapse_workspaces[each.value.synapse_workspace_key].id
}

module synapse_spark_pool {
  source     = "./modules/analytics/synapse/addons/spark_pool"
  depends_on = [module.synapse_workspaces]
  for_each   = try(local.database.synapse_addons.synapse_spark_pool, {})

  global_settings      = local.global_settings
  settings             = each.value
  synapse_workspace_id = module.synapse_workspaces[each.value.synapse_workspace_key].id
}

