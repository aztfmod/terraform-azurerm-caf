module keyvault_certificate_issuers {
  source     = "./modules/security/keyvault_certificate_issuer"
  depends_on = [module.keyvaults]
  for_each   = var.keyvault_certificate_issuers

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = module.resource_groups[each.value.resource_group_key].location
  global_settings     = local.global_settings
  settings            = each.value
  keyvault_id         = try(local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key].id, local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key].id)
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  password            = try(data.azurerm_key_vault_secret.certificate_issuer_password[each.key].value, each.value.cert_issuer_password)
}

data "azurerm_key_vault_secret" "certificate_issuer_password" {
  depends_on = [module.dynamic_keyvault_secrets]
  for_each = {
    for key, value in var.keyvault_certificate_issuers : key => value
    if try(value.cert_password_key, null) != null
  }

  name         = each.value.cert_password_key
  key_vault_id = try(local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key].id, local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key].id)
}

output keyvault_certificate_issuers {
  value     = module.keyvault_certificate_issuers
  
}
