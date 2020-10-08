
output mssql_servers {
  value     = module.mssql_servers
  sensitive = true
}

module "mssql_servers" {
  source     = "./modules/databases/mssql_server"
  depends_on = [module.keyvault_access_policies]
  for_each   = local.database.mssql_servers

  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  keyvault_id         = try(each.value.administrator_login_password, null) == null ? module.keyvaults[each.value.keyvault_key].id : null
  storage_accounts    = module.storage_accounts
  azuread_groups      = module.azuread_groups
  vnets               = local.combined_objects_networking
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = try(each.value.private_endpoints, {}) == {} ? null : module.resource_groups
}