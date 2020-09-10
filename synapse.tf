module synapse_workspaces {
  source   = "./modules/analytics/synapse"
  for_each = local.database.synapse_workspaces

  location                             = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name                  = module.resource_groups[each.value.resource_group_key].name
  global_settings                      = local.global_settings
  settings                             = each.value
  storage_data_lake_gen2_filesystem_id = module.storage_accounts[each.value.data_lake_filesystem.storage_account_key].data_lake_filesystems[each.value.data_lake_filesystem.container_key].id
}