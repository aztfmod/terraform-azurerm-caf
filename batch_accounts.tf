module "batch_accounts" {
  source   = "./modules/compute/batch/batch_account"
  for_each = local.compute.batch_accounts

  global_settings     = local.global_settings
  client_config       = local.client_config
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  diagnostics         = local.combined_diagnostics
  settings            = each.value
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  keyvault            = try(local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.keyvault.key], null)
  key_vault_key_id    = try(local.combined_objects_keyvault_keys[try(each.value.keyvault_key.lz_key, local.client_config.landingzone_key)][try(each.value.key_vault_key_key, each.value.key_vault_key.key)].id, null)
  storage_account_id  = try(module.storage_accounts[each.value.storage_account_key].id, null)
  resource_groups     = local.combined_objects_resource_groups
  vnets               = local.combined_objects_networking
  private_dns         = local.combined_objects_private_dns
  private_endpoints   = try(each.value.private_endpoints, {})
}

output "batch_accounts" {
  value = module.batch_accounts
}
