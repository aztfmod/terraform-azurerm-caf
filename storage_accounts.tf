
module "storage_accounts" {
  source   = "./modules/storage_account"
  for_each = var.storage_accounts

  client_config             = local.client_config
  diagnostic_profiles       = try(each.value.diagnostic_profiles, {})
  diagnostic_profiles_blob  = try(each.value.diagnostic_profiles_blob, {})
  diagnostic_profiles_queue = try(each.value.diagnostic_profiles_queue, {})
  diagnostic_profiles_table = try(each.value.diagnostic_profiles_table, {})
  diagnostic_profiles_file  = try(each.value.diagnostic_profiles_file, {})
  diagnostics               = local.combined_diagnostics
  global_settings           = local.global_settings
  managed_identities        = local.combined_objects_managed_identities
  private_dns               = local.combined_objects_private_dns
  private_endpoints         = try(each.value.private_endpoints, {})
  recovery_vaults           = local.combined_objects_recovery_vaults
  storage_account           = each.value
  var_folder_path           = var.var_folder_path
  vnets                     = local.combined_objects_networking
  virtual_subnets           = local.combined_objects_virtual_subnets

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

output "storage_accounts" {
  value     = module.storage_accounts
  sensitive = true
}

resource "azurerm_storage_account_customer_managed_key" "cmk" {
  depends_on = [module.keyvault_access_policies]
  for_each = {
    for key, value in var.storage_accounts : key => value
    if can(value.customer_managed_key)
  }

  storage_account_id = module.storage_accounts[each.key].id
  key_vault_id       = local.combined_objects_keyvaults[try(each.value.customer_managed_key.lz_key, local.client_config.landingzone_key)][each.value.customer_managed_key.keyvault_key].id
  key_name           = can(each.value.customer_managed_key.key_name) ? each.value.customer_managed_key.key_name : local.combined_objects_keyvault_keys[try(each.value.customer_managed_key.lz_key, local.client_config.landingzone_key)][each.value.customer_managed_key.keyvault_key_key].name
  key_version        = try(each.value.customer_managed_key.key_version, null)
}

module "encryption_scopes" {
  source = "./modules/storage_account/encryption_scope"
  for_each = {
    for key, value in var.storage_accounts : key => value
    if can(value.encryption_scopes)
  }

  client_config      = local.client_config
  settings           = each.value
  storage_account_id = module.storage_accounts[each.key].id
  keyvault_keys      = local.combined_objects_keyvault_keys
}

module "local_users" {
  source = "./modules/storage_account/local_users"
  for_each = {
    for key, value in var.storage_accounts : key => value
    if can(value.local_users)
  }
  storage_account_id = module.storage_accounts[each.key].id
  settings           = each.value
  client_config      = local.client_config
  remote_objects = {
    keyvaults = local.combined_objects_keyvaults
  }
}