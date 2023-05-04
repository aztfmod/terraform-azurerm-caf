resource "azurerm_storage_encryption_scope" "versioned" {
  for_each = {
    for key, value in try(var.settings.encryption_scopes, {}) : key => value
    if try(value.keyvault_key.versionless, false) == false
  }

  name                               = each.value.name
  storage_account_id                 = var.storage_account_id
  source                             = each.value.source
  infrastructure_encryption_required = try(each.value.infrastructure_encryption_required, true)
  key_vault_key_id                   = each.value.source == "Microsoft.KeyVault" ? try(each.value.keyvault_key.id, var.keyvault_keys[try(each.value.keyvault_key.lz_key, var.client_config.landingzone_key)][each.value.keyvault_key.key].id) : null
}

resource "azurerm_storage_encryption_scope" "versionless" {
  for_each = {
    for key, value in try(var.settings.encryption_scopes, {}) : key => value
    if try(value.keyvault_key.versionless, false)
  }

  name                               = each.value.name
  storage_account_id                 = var.storage_account_id
  source                             = each.value.source
  infrastructure_encryption_required = try(each.value.infrastructure_encryption_required, true)
  key_vault_key_id                   = each.value.source == "Microsoft.KeyVault" ? try(each.value.keyvault_key.id, var.keyvault_keys[try(each.value.keyvault_key.lz_key, var.client_config.landingzone_key)][each.value.keyvault_key.key].versionless_id) : null
}


# encryption_scopes = {
#   rover = {
#     name                               = "rover"
#     source                             = "Microsoft.KeyVault"
#     infrastructure_encryption_required = true

#     # Keyvault encryption key
#     keyvault_key = {
#       key = "cmk1"
#     }
#   }
#   versionless = {
#     name                               = "rotate"
#     source                             = "Microsoft.KeyVault"
#     infrastructure_encryption_required = true

#     # Keyvault encryption key
#     keyvault_key = {
#       key         = "cmk1"
#       versionless = true
#     }
#   }
#   microsoft_managed = {
#     name   = "default"
#     source = "Microsoft.Storage"
#   }
# }
