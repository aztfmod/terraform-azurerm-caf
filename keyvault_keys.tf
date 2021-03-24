module keyvault_keys {
  depends_on = [module.keyvaults, module.keyvault_access_policies]

  source = "./modules/security/keyvault_key"

  for_each = local.security.keyvault_keys

  settings  = each.value
  keyvault  = try(local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key], local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key])
  base_tags = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

}


output keyvault_keys {
  value     = module.keyvault_keys
}