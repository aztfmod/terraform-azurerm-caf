resource "azurerm_key_vault_access_policy" "policy" {
  for_each = local.final

  key_vault_id            = var.keyvault_id
  tenant_id               = each.value.tenant_id
  object_id               = each.value.object_id
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
        for key, access_policy_object in var.access_policies : {
          keyvault_key            = key
          user_object_id          = try(access_policy_object.object_id,"") == "logged_in_user" ? data.azurerm_client_config.current.object_id : access_policy_object.object_id
          group_key_object_id     = lookup(access_policy_object, "azuread_group_key", null) == null ? "" : var.azuread_groups[access_policy_object.azuread_group_key].id
          tenant_id               = lookup(access_policy_object, "azuread_group_key", null) == null ? data.azurerm_client_config.current.tenant_id : var.azuread_groups[access_policy_object.azuread_group_key].tenant_id
          key_permissions         = lookup(access_policy_object, "key_permissions", [])
          secret_permissions      = lookup(access_policy_object, "secret_permissions", [])
          certificate_permissions = lookup(access_policy_object, "certificate_permissions", [])
          storage_permissions     = lookup(access_policy_object, "storage_permissions", [])
        }
      ]
    ) : access_policy_objects.keyvault_key => access_policy_objects
  }

  final = {
    for access_policy_objects in
    flatten(
      [
        for access_policy_key, access_policy_object in local.access_policy_objects : {
          key                     = access_policy_key
          object_id               = format("%s%s", access_policy_object.user_object_id, access_policy_object.group_key_object_id)
          tenant_id               = access_policy_object.tenant_id
          key_permissions         = access_policy_object.key_permissions
          secret_permissions      = access_policy_object.secret_permissions
          certificate_permissions = access_policy_object.certificate_permissions
          storage_permissions     = access_policy_object.storage_permissions
        }
      ]
    ) : access_policy_objects.key => access_policy_objects
  }
}