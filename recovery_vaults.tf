module "recovery_vaults" {
  source   = "./modules/recovery_vault"
  for_each = local.shared_services.recovery_vaults

  global_settings   = local.global_settings
  client_config     = local.client_config
  settings          = each.value
  diagnostics       = local.combined_diagnostics
  identity          = try(each.value.identity, null)
  vnets             = try(local.combined_objects_networking, {})
  private_endpoints = try(each.value.private_endpoints, {})
  private_dns       = local.combined_objects_private_dns
  resource_group    = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)]
  base_tags         = local.global_settings.inherit_tags

  # support for CMK encryption
  # key_id = can(each.value.encryption.key_id) ? each.value.encryption.key_id : try(local.combined_objects_keyvault_keys[try(each.value.encryption.keyvault_key.lz_key, local.client_config.landingzone_key)][try(each.value.encryption.key_vault_key_key, each.value.encryption.key_vault_key.key)].id, null)
  key_id = try(local.combined_objects_keyvault_keys[try(each.value.encryption.keyvault_key.lz_key, local.client_config.landingzone_key)][try(each.value.encryption.key_vault_key_key, each.value.encryption.key_vault_key.key)].id, null)
  # try(local.combined_objects_keyvault_keys[try(each.value.encryption.keyvault_key.lz_key, local.client_config.landingzone_key)][each.value.encryption.keyvault_key.key].id, null)
  # keyvault_id = can(each.value.encryption) ? (can(each.value.encryption.key_id) ? null : local.combined_objects_keyvaults[try(each.value.encryption.keyvault.lz_key, local.client_config.landingzone_key)][each.value.encryption.keyvault.key].id) : null
}

output "recovery_vaults" {
  value = module.recovery_vaults
}
