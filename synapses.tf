module "synapse_workspaces" {
  source     = "./modules/analytics/synapse"
  depends_on = [module.keyvault_access_policies, module.keyvault_access_policies_azuread_apps]
  for_each   = local.database.synapse_workspaces

  location                             = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name                  = local.resource_groups[each.value.resource_group_key].name
  global_settings                      = local.global_settings
  settings                             = each.value
  storage_data_lake_gen2_filesystem_id = try(each.value.lz_key, null) == null ? local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.data_lake_filesystem.storage_account_key].data_lake_filesystems[each.value.data_lake_filesystem.container_key].id : local.combined_objects_storage_accounts[each.value.lz_key][each.value.data_lake_filesystem.storage_account_key].data_lake_filesystems[each.value.data_lake_filesystem.container_key].id
  keyvault_id                          = try(each.value.sql_administrator_login_password, null) == null ? module.keyvaults[each.value.keyvault_key].id : null
  base_tags                            = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "synapse_workspaces" {
  value = module.synapse_workspaces

}



