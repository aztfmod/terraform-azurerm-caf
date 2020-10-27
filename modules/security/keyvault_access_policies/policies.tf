
module azuread_apps {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if try(access_policy.azuread_app_key, null) != null
  }

  keyvault_id   = var.keyvault_id == null ? try(var.keyvaults[var.client_config.landingzone_key][var.keyvault_key].id, var.keyvaults[each.value.lz_key][var.keyvault_key].id) : var.keyvault_id
  access_policy = each.value
  tenant_id     = var.client_config.tenant_id
  object_id     = try(var.azuread_apps[var.client_config.landingzone_key][each.value.azuread_app_key].azuread_service_principal.object_id, var.azuread_apps[each.value.lz_key][each.value.azuread_app_key].azuread_service_principal.object_id)
}

module azuread_group {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if try(access_policy.azuread_group_key, null) != null
  }

  keyvault_id   = var.keyvault_id == null ? try(var.keyvaults[var.client_config.landingzone_key][var.keyvault_key].id, var.keyvaults[each.value.lz_key][var.keyvault_key].id) : var.keyvault_id
  access_policy = each.value
  tenant_id     = var.client_config.tenant_id
  object_id     = try(each.value.lz_key , null) == null ? var.azuread_groups[var.client_config.landingzone_key][each.value.azuread_group_key].id : var.azuread_groups[each.value.lz_key][each.value.azuread_group_key].id
}

module logged_in_user {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if key == "logged_in_user" && var.client_config.logged_user_objectId != null
  }

  # keyvault_id   = var.keyvault_id == null ? try(each.value.lz_key, null) == null ? var.keyvaults[var.keyvault_key].id : var.keyvaults[each.value.lz_key][var.keyvault_key].id : var.keyvault_id
  keyvault_id   = var.keyvault_id == null ? try(var.keyvaults[var.client_config.landingzone_key][var.keyvault_key].id, var.keyvaults[each.value.lz_key][var.keyvault_key].id) : var.keyvault_id
  access_policy = each.value
  tenant_id     = var.client_config.tenant_id
  object_id     = var.client_config.logged_user_objectId
}

module logged_in_aad_app {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if key == "logged_in_aad_app" && var.client_config.logged_aad_app_objectId != null
  }

  keyvault_id   = var.keyvault_id == null ? try(var.keyvaults[var.client_config.landingzone_key][var.keyvault_key].id, var.keyvaults[each.value.lz_key][var.keyvault_key].id) : var.keyvault_id
  access_policy = each.value
  tenant_id     = var.client_config.tenant_id
  object_id     = var.client_config.logged_aad_app_objectId
}

module object_id {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if try(access_policy.object_id, null) != null && var.client_config.logged_aad_app_objectId != null
  }

  keyvault_id   = var.keyvault_id == null ? try(var.keyvaults[var.client_config.landingzone_key][var.keyvault_key].id, var.keyvaults[each.value.lz_key][var.keyvault_key].id) : var.keyvault_id
  access_policy = each.value
  tenant_id     = try(each.value.tenant_id, var.client_config.tenant_id)
  object_id     = each.value.object_id
}

module managed_identity {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if try(access_policy.managed_identity_key, null) != null
  }

  keyvault_id   = var.keyvault_id == null ? try(var.keyvaults[var.client_config.landingzone_key][var.keyvault_key].id, var.keyvaults[each.value.lz_key][var.keyvault_key].id) : var.keyvault_id
  access_policy = each.value
  tenant_id     = var.client_config.tenant_id
  object_id     = try(each.value.lz_key, null) == null ? var.managed_identities[var.client_config.landingzone_key][each.value.managed_identity_key].principal_id : var.managed_identities[each.value.lz_key][each.value.managed_identity_key].principal_id
}