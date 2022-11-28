module "disk_encryption_sets" {
  source   = "./modules/security/disk_encryption_set"
  for_each = local.security.disk_encryption_sets

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  key_vault_key_id    = local.combined_objects_keyvault_keys[try(each.value.keyvault_key.lz_key, local.client_config.landingzone_key)][try(each.value.key_vault_key_key, each.value.key_vault_key.key)].id
  keyvault_id         = local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.keyvault.key].id
}

output "disk_encryption_sets" {
  value = module.disk_encryption_sets
}
