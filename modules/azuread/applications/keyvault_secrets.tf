
resource "azurerm_key_vault_secret" "client_id" {
  for_each = try(var.settings.keyvaults, {})

  name         = format("%s-client-id", each.value.secret_prefix)
  value        = azuread_application.app.application_id
  key_vault_id = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id

  lifecycle {
    ignore_changes = [
      value
    ]
  }

}

resource "azurerm_key_vault_secret" "client_secret" {
  for_each        = try(var.settings.keyvaults, {})
  name            = format("%s-client-secret", each.value.secret_prefix)
  value           = azuread_service_principal_password.app.value
  key_vault_id    = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
  expiration_date = timeadd(timestamp(), format("%sh", try(var.settings.password_expire_in_days, 180) * 24))

  lifecycle {
    ignore_changes = [
      expiration_date, value
    ]
  }
}

resource "azurerm_key_vault_secret" "tenant_id" {
  for_each     = try(var.settings.keyvaults, {})
  name         = format("%s-tenant-id", each.value.secret_prefix)
  value        = var.client_config.tenant_id
  key_vault_id = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
}
