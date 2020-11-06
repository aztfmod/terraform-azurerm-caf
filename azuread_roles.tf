
module azuread_roles_applications {
  source   = "./modules/azuread/roles"
  for_each = try(var.azuread_roles.azuread_apps, {})

  object_id     = module.azuread_applications[each.key].azuread_service_principal.object_id
  azuread_roles = each.value.roles
}

module azuread_roles_msi {
  source   = "./modules/azuread/roles"
  for_each = try(var.azuread_roles.managed_identities, {})

  object_id     = module.managed_identities[each.key].principal_id
  azuread_roles = each.value.roles
}