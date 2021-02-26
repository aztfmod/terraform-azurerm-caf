module "disk_encryption_sets" {
  source   = "./modules/security/disk_encryption_set"
  for_each = local.security.disk_encryption_sets

  global_settings    = local.global_settings
  client_config      = local.client_config
  settings           = each.value
  resource_groups    = module.resource_groups
  base_tags          = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  key_vault_key_ids  = module.keyvault_keys
}

output disk_encryption_sets {
  value = module.disk_encryption_sets
}
