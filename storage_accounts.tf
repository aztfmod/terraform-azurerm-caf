
module "storage_accounts" {
  source   = "./modules/storage_account"
  for_each = var.storage_accounts

  global_settings     = local.global_settings
  client_config       = local.client_config
  storage_account     = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  vnets               = local.combined_objects_networking
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = try(each.value.private_endpoints, {}) == {} ? null : local.resource_groups
  recovery_vaults     = local.combined_objects_recovery_vaults
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  private_dns         = local.combined_objects_private_dns
}

output "storage_accounts" {
  value = module.storage_accounts

}

resource "azurerm_storage_account_customer_managed_key" "cmk" {
  depends_on = [module.keyvault_access_policies]
  for_each = {
    for key, value in var.storage_accounts : key => value
    if try(value.customer_managed_key, null) != null
  }

  storage_account_id = module.storage_accounts[each.key].id
  key_vault_id       = module.keyvaults[each.value.customer_managed_key.keyvault_key].id
  key_name           = module.keyvault_keys[each.value.customer_managed_key.keyvault_key_key].name
}
