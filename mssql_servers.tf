
output mssql_servers {
  value     = module.mssql_servers
  
}

module "mssql_servers" {
  source     = "./modules/databases/mssql_server"
  depends_on = [module.keyvault_access_policies, module.keyvault_access_policies_azuread_apps]
  for_each   = local.database.mssql_servers

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  keyvault_id         = try(each.value.administrator_login_password, null) != null ? null : try(each.value.lz_key, null) == null ? local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key].id : local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key].id
  storage_accounts    = module.storage_accounts
  azuread_groups      = local.combined_objects_azuread_groups
  vnets               = local.combined_objects_networking
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = try(each.value.private_endpoints, {}) == {} ? null : module.resource_groups
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  private_dns         = local.combined_objects_private_dns
}

module "mssql_failover_groups" {
  source   = "./modules/databases/mssql_server/failover_group"
  for_each = local.database.mssql_failover_groups

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  primary_server_name = local.combined_objects_mssql_servers[try(each.value.primary_server.lz_key, local.client_config.landingzone_key)][each.value.primary_server.sql_server_key].name
  secondary_server_id = local.combined_objects_mssql_servers[try(each.value.secondary_server.lz_key, local.client_config.landingzone_key)][each.value.secondary_server.sql_server_key].id
  databases           = local.combined_objects_mssql_databases
}