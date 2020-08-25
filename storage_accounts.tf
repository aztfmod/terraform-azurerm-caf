
module "storage_accounts" {
  source = "./modules/storage_account"

  for_each = var.storage_accounts

  global_settings     = local.global_settings
  storage_account     = each.value
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  vnets               = try(each.value.private_endpoints, {}) == {} ? null : local.vnets
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = try(each.value.private_endpoints, {}) == {} ? null : azurerm_resource_group.rg
}

module diagnostic_storage_accounts {
  source = "./modules/storage_account"

  for_each = var.diagnostic_storage_accounts

  global_settings     = local.global_settings
  storage_account     = each.value
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
}

output storage_accounts {
  value = module.storage_accounts
}
