locals {
  secrets_to_store_in_keyvault = {
    for aad_app in
    flatten(
      [
        for key, app in var.aad_apps : {
          app_application_id      = lookup(app, "app_application_id", null)
          app_object_id           = lookup(app, "app_object_id", null)
          sp_object_id            = lookup(app, "sp_object_id", null)
          application_name        = lookup(app, "application_name", null)
          keyvault_key            = app.keyvault.keyvault_key
          secret_prefix           = app.keyvault.secret_prefix
          aad_app_key             = key
          password_expire_in_days = app.password_expire_in_days
        } if lookup(app, "keyvault", null) != null
      ]
    ) : aad_app.aad_app_key => aad_app
  }

  aad_apps_output = {
    for aad_app_keyvault in
    flatten(
      [
        for key, aad_app in local.secrets_to_store_in_keyvault : {
          aad_app_key = key
          tenant_id   = data.azurerm_client_config.current.tenant_id
          azuread_application = {
            id             = lookup(azuread_application.aad_apps, key, null) == null ? aad_app.app_object_id : azuread_application.aad_apps[key].id
            object_id      = lookup(azuread_application.aad_apps, key, null) == null ? aad_app.app_object_id : azuread_application.aad_apps[key].object_id
            application_id = lookup(azuread_application.aad_apps, key, null) == null ? aad_app.app_application_id : azuread_application.aad_apps[key].application_id
            name           = lookup(azuread_application.aad_apps, key, null) == null ? aad_app.application_name : azuread_application.aad_apps[key].name
          }
          azuread_service_principal = {
            id                     = lookup(azuread_application.aad_apps, key, null) == null ? aad_app.sp_object_id : azuread_service_principal.aad_apps[key].id
            object_id              = lookup(azuread_application.aad_apps, key, null) == null ? aad_app.sp_object_id : azuread_service_principal.aad_apps[key].object_id
            keyvault_id            = var.keyvaults[aad_app.keyvault_key].id
            keyvault_name          = var.keyvaults[aad_app.keyvault_key].name
            keyvault_client_secret = format("%s-client-secret", aad_app.secret_prefix)
          }
        }
      ]
    ) : aad_app_keyvault.aad_app_key => aad_app_keyvault
  }

}




resource "azurerm_key_vault_secret" "aad_app_client_id" {
  depends_on = [azuread_service_principal_password.aad_apps]

  for_each = local.secrets_to_store_in_keyvault

  name         = format("%s-client-id", each.value.secret_prefix)
  value        = lookup(azuread_application.aad_apps, each.key, null) == null ? each.value.app_application_id : azuread_application.aad_apps[each.key].application_id
  key_vault_id = var.keyvaults[each.value.keyvault_key].id

}

resource "azurerm_key_vault_secret" "aad_app_client_secret" {
  depends_on = [azuread_service_principal_password.aad_apps]

  for_each = local.secrets_to_store_in_keyvault

  name            = format("%s-client-secret", each.value.secret_prefix)
  value           = lookup(azuread_application.aad_apps, each.key, null) == null ? "" : azuread_service_principal_password.aad_apps[each.key].value
  key_vault_id    = var.keyvaults[each.value.keyvault_key].id
  expiration_date = timeadd(timestamp(), format("%sh", each.value.password_expire_in_days * 24))

  lifecycle {
    ignore_changes = [
      expiration_date, value
    ]
  }
}

resource "azurerm_key_vault_secret" "aad_app_tenant_id" {
  depends_on = [azuread_service_principal_password.aad_apps]

  for_each = local.secrets_to_store_in_keyvault

  name         = format("%s-tenant-id", each.value.secret_prefix)
  value        = data.azurerm_client_config.current.tenant_id
  key_vault_id = var.keyvaults[each.value.keyvault_key].id

}