module "keyvault_certificate_issuers" {
  source     = "./modules/security/keyvault_certificate_issuer"
  depends_on = [module.keyvaults]
  for_each   = local.security.keyvault_certificate_issuers

  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  location            = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location
  global_settings     = local.global_settings
  settings            = each.value
  keyvault_id         = try(local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key].id, local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key].id)
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
  password            = try(data.azurerm_key_vault_secret.certificate_issuer_password[each.key].value, each.value.cert_issuer_password)
}

data "azurerm_key_vault_secret" "certificate_issuer_password" {
  depends_on = [module.dynamic_keyvault_secrets]
  for_each = {
    for key, value in local.security.keyvault_certificate_issuers : key => value
    if try(value.cert_password_key, null) != null
  }

  name         = var.security.dynamic_keyvault_secrets[each.value.keyvault_key][each.value.cert_password_key].secret_name
  key_vault_id = local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].id
}

output "keyvault_certificate_issuers" {
  value = module.keyvault_certificate_issuers

}
