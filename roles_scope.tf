# to address circular references with high-depedencies/cardinalities services.
resource "azurerm_role_assignment" "scope" {
  for_each = {
    for key, value in try(local.roles_to_process, {}) : key => value
    if contains(keys(local.services_scope), value.scope_resource_key)
  }

  principal_id         = each.value.object_id_resource_type == "object_ids" ? each.value.object_id_key_resource : each.value.object_id_lz_key == null ? local.services_scope_rbac_id[each.value.object_id_resource_type][var.current_landingzone_key][each.value.object_id_key_resource].rbac_id : local.services_scope_rbac_id[each.value.object_id_resource_type][each.value.object_id_lz_key][each.value.object_id_key_resource].rbac_id
  role_definition_id   = each.value.mode == "custom_role_mapping" ? module.custom_roles[each.value.role_definition_name].role_definition_resource_id : null
  role_definition_name = each.value.mode == "built_in_role_mapping" ? each.value.role_definition_name : null
  scope                = each.value.scope_lz_key == null ? local.services_scope[each.value.scope_resource_key][var.current_landingzone_key][each.value.scope_key_resource].id : local.services_scope[each.value.scope_resource_key][each.value.scope_lz_key][each.value.scope_key_resource].id
}

locals {
  services_scope = {
    azuread_users    = local.combined_objects_azuread_users
    virtual_machines = local.combined_objects_virtual_machines
  }

  services_scope_rbac_id = {
    azuread_groups             = local.combined_objects_azuread_groups
    azuread_service_principals = local.combined_objects_azuread_service_principals
    azuread_users              = local.combined_objects_azuread_users
    logged_in                  = local.logged_in
    managed_identities         = local.combined_objects_managed_identities
  }
}