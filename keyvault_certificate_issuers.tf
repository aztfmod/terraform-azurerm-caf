module keyvault_certificate_issuers {
  source   = "./modules/security/keyvault_certificate_issuer"
  for_each = var.keyvault_certificate_issuers
  
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = module.resource_groups[each.value.resource_group_key].location
  global_settings     = local.global_settings
  settings            = each.value
  org_id              = each.value.org_id
  keyvault_id         = try(each.value.administrator_login_password, null) != null ? null : try(each.value.lz_key, null) == null ? local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key].id : local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key].id
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output keyvault_certificate_issuers {
  value     = module.keyvault_certificate_issuers
  sensitive = true
}
