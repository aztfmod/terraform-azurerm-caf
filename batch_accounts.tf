module "batch_accounts" {
  source   = "./modules/compute/batch/batch_account"
  for_each = local.compute.batch_accounts

  global_settings                     = local.global_settings
  client_config                       = local.client_config
  diagnostics                         = local.combined_diagnostics
  settings                            = each.value
  keyvault                            = try(local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.keyvault.key], null)
  key_vault_key_id                    = try(local.combined_objects_keyvault_keys[try(each.value.keyvault_key.lz_key, local.client_config.landingzone_key)][try(each.value.key_vault_key_key, each.value.key_vault_key.key)].id, null)
  storage_account_id                  = try(local.combined_objects_storage_accounts[try(each.value.storage_account.lz_key, local.client_config.landingzone_key)][try(each.value.storage_account_key, each.value.storage_account.key)].id, null)
  storage_account_authentication_mode = try(each.value.storage_account_authentication_mode, null)
  private_endpoints                   = try(each.value.private_endpoints, {})

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)

  remote_objects = {
    managed_identities = local.combined_objects_managed_identities
    private_dns        = local.combined_objects_private_dns
    vnets              = local.combined_objects_networking
    resource_groups    = try(each.value.private_endpoints, {}) == {} ? null : local.combined_objects_resource_groups
  }

}

output "batch_accounts" {
  value = module.batch_accounts
}
