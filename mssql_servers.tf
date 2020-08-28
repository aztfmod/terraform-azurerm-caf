
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
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  keyvault_id         = try(each.value.administrator_login_password, null) == null ? module.keyvaults[each.value.keyvault_key].id : null
  storage_accounts    = module.storage_accounts
  azuread_groups      = module.azuread_groups
  vnets               = try(each.value.private_endpoints, {}) == {} ? null : local.vnets
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = try(each.value.private_endpoints, {}) == {} ? null : azurerm_resource_group.rg
  tfstates            = var.tfstates
  use_msi             = var.use_msi
}