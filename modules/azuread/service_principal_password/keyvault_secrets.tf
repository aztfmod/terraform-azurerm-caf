
resource "azurerm_key_vault_secret" "client_id" {
  for_each = try(var.settings.keyvaults, {})

  name         = format("%s-client-id", each.value.secret_prefix)
  value        = var.service_principal_application_id
  key_vault_id = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
}

resource "azurerm_key_vault_secret" "client_secret" {
  for_each        = try(var.settings.keyvaults, {})
  name            = format("%s-client-secret", each.value.secret_prefix)
  value           = azuread_service_principal_password.pwd.value
  key_vault_id    = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
  expiration_date = timeadd(time_rotating.pwd.id, format("%sh", local.password_policy.expire_in_days * 24))
}

resource "azurerm_key_vault_secret" "tenant_id" {
  for_each     = try(var.settings.keyvaults, {})
  name         = format("%s-tenant-id", each.value.secret_prefix)
  value        = var.client_config.tenant_id
  key_vault_id = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
}
