module "keyvault_certificate_issuers" {
  source     = "./modules/security/keyvault_certificate_issuer"
  depends_on = [module.keyvaults]
  for_each   = local.security.keyvault_certificate_issuers

  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

  global_settings = local.global_settings
  settings        = each.value
  keyvault_id     = can(each.value.keyvault_id) ? each.value.keyvault_id : local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].id
  password        = try(data.azurerm_key_vault_secret.certificate_issuer_password[each.key].value, each.value.cert_issuer_password)
}

data "azurerm_key_vault_secret" "certificate_issuer_password" {
  depends_on = [module.dynamic_keyvault_secrets]
  for_each = {
    for key, value in local.security.keyvault_certificate_issuers : key => value
    if try(value.cert_password_key, null) != null
  }

  name         = var.security.dynamic_keyvault_secrets[each.value.keyvault_key][each.value.cert_password_key].secret_name
  key_vault_id = can(each.value.key_vault_id) ? each.value.key_vault_id : local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].id
}

output "keyvault_certificate_issuers" {
  value = module.keyvault_certificate_issuers

}
