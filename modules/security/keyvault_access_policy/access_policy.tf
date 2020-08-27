resource "azurerm_key_vault_access_policy" "policy" {
  for_each = local.access_policy_objects

  key_vault_id            = var.keyvault_id
  tenant_id               = each.value.tenant_id
  object_id               = format("%s%s%s", each.value.user_object_id, each.value.logged_aad_aap_object_id, each.value.group_key_object_id)
  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
  storage_permissions     = each.value.storage_permissions
}

# Resolve the object_id
locals {

  access_policy_objects = {
    for access_policy_objects in
    flatten(
      [
        for key, access_policy_object in try(var.access_policies, {}) : {
          access_policy_key        = key
          user_object_id           = key == "logged_in_user" ? var.logged_user_objectId : ""
          logged_aad_aap_object_id = key == "logged_in_aad_app" ? var.logged_aad_app_objectId : ""
          group_key_object_id      = try(var.azuread_groups[access_policy_object.azuread_group_key].id, "")
          tenant_id                = data.azurerm_client_config.current.tenant_id
          key_permissions          = try(access_policy_object.key_permissions, [])
          secret_permissions       = try(access_policy_object.secret_permissions, [])
          certificate_permissions  = try(access_policy_object.certificate_permissions, [])
          storage_permissions      = try(access_policy_object.storage_permissions, [])
        }
      ]
    ) : access_policy_objects.access_policy_key => access_policy_objects
  }

}