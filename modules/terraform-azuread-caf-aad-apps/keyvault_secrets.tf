#
# The client-id, client-secret and tenant-id are stored into the keyvault to support password rotation
#

locals {
  secrets_to_store_in_keyvault = {
    for aad_app in
    flatten(
      [
        for key, app in var.azuread_apps : {
          app_application_id      = try(app.app_application_id, null)
          app_object_id           = try(app.app_object_id, null)
          sp_object_id            = try(app.sp_object_id, null)
          application_name        = try(app.application_name, null)
          keyvault                = app.keyvault
          aad_app_key             = key
          password_expire_in_days = app.password_expire_in_days
        } if try(app.keyvault, null) != null
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
            id             = try(azuread_application.aad_apps[key].id, aad_app.app_object_id)
            object_id      = try(azuread_application.aad_apps[key].object_id, aad_app.app_object_id)
            application_id = try(azuread_application.aad_apps[key].application_id, aad_app.app_application_id)
            name           = try(azuread_application.aad_apps[key].name, aad_app.application_name)
          }
          azuread_service_principal = {
            id                     = try(azuread_service_principal.aad_apps[key].id, aad_app.sp_object_id)
            object_id              = try(azuread_service_principal.aad_apps[key].object_id, aad_app.sp_object_id)
            keyvault_id            = try(var.keyvaults[aad_app.keyvault.keyvault_key].id, data.terraform_remote_state.keyvaults[aad_app.keyvault.keyvault_key].id)
            keyvault_name          = try(var.keyvaults[aad_app.keyvault.keyvault_key].id, data.terraform_remote_state.keyvaults[aad_app.keyvault.keyvault_key].name)
            keyvault_client_secret = format("%s-client-secret", aad_app.keyvault.secret_prefix)
          }
        }
      ]
    ) : aad_app_keyvault.aad_app_key => aad_app_keyvault
  }

}

data "terraform_remote_state" "keyvaults" {
  for_each = {
    for key, keyvault in local.secrets_to_store_in_keyvault : key => keyvault
    if try(keyvault.keyvault.remote_tfstate, null) != null
  }

  backend = "azurerm"
  config = {
    storage_account_name = var.tfstates[each.value.keyvault.remote_tfstate.tfstate_key].storage_account_name
    container_name       = var.tfstates[each.value.keyvault.remote_tfstate.tfstate_key].container_name
    resource_group_name  = var.tfstates[each.value.keyvault.remote_tfstate.tfstate_key].resource_group_name
    key                  = var.tfstates[each.value.keyvault.remote_tfstate.tfstate_key].key
    use_msi              = var.use_msi
    subscription_id      = var.use_msi ? var.tfstates[each.value.keyvault.remote_tfstate.tfstate_key].subscription_id : null
    tenant_id            = var.use_msi ? var.tfstates[each.value.keyvault.remote_tfstate.tfstate_key].tenant_id : null
  }
}


resource "azurerm_key_vault_secret" "aad_app_client_id" {
  depends_on = [azuread_service_principal_password.aad_apps]

  for_each = local.secrets_to_store_in_keyvault

  name         = format("%s-client-id", each.value.keyvault.secret_prefix)
  value        = try(azuread_application.aad_apps[each.key].application_id, each.value.app_application_id)
  key_vault_id = try(var.keyvaults[each.value.keyvault.keyvault_key].id, data.terraform_remote_state.keyvaults[each.value.keyvault.keyvault_key].id)

}

resource "azurerm_key_vault_secret" "aad_app_client_secret" {
  depends_on = [azuread_service_principal_password.aad_apps]

  for_each = local.secrets_to_store_in_keyvault

  name            = format("%s-client-secret", each.value.keyvault.secret_prefix)
  value           = try(azuread_service_principal_password.aad_apps[each.key].value, "")
  key_vault_id    = try(var.keyvaults[each.value.keyvault.keyvault_key].id, data.terraform_remote_state.keyvaults[each.value.keyvault.keyvault_key].id)
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

  name         = format("%s-tenant-id", each.value.keyvault.secret_prefix)
  value        = data.azurerm_client_config.current.tenant_id
  key_vault_id = try(var.keyvaults[each.value.keyvault.keyvault_key].id, data.terraform_remote_state.keyvaults[each.value.keyvault.keyvault_key].id)

  lifecycle {
    ignore_changes = [
      expiration_date, value
    ]
  }
}