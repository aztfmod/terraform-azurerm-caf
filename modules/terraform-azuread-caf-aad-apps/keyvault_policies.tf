locals {
  aad_apps_access_policies = {
    for access_policy in
    flatten(
      [
        for key, app in var.azuread_apps : {
          aad_app_key             = key
          keyvault_key            = lookup(app, "keyvault", null) == null ? null : app.keyvault.keyvault_key
          key_permissions         = try(app.keyvault.access_policies.key_permissions, null)
          secret_permissions      = try(app.keyvault.access_policies.secret_permissions, null)
          certificate_permissions = try(app.keyvault.access_policies.certificate_permissions, null)
          storage_permissions     = try(app.keyvault.access_policies.storage_permissions, null)
          sp_object_id            = lookup(app, "sp_object_id", null)
        } if lookup(app.keyvault, "access_policies", null) != null
      ]
    ) : access_policy.aad_app_key => access_policy
  }
}

resource "azurerm_key_vault_access_policy" "policy" {
  for_each = local.aad_apps_access_policies

  key_vault_id = try(var.keyvaults[each.value.keyvault.keyvault_key].id, data.terraform_remote_state.keyvaults[each.key].outputs[each.value.keyvault.remote_tfstate.output_key][each.value.keyvault.keyvault_key].id)

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = lookup(azuread_service_principal.aad_apps, each.value.aad_app_key, null) == null ? each.value.sp_object_id : azuread_service_principal.aad_apps[each.value.aad_app_key].object_id

  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
  storage_permissions     = each.value.storage_permissions

  lifecycle {
    ignore_changes = [tenant_id, object_id, key_vault_id]
  }
}

