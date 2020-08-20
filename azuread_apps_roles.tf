
module azuread_app_roles {
  source = "./modules/azuread/roles"

  for_each = var.azuread_app_roles

  object_id         = module.azuread_applications.aad_apps[each.key].azuread_service_principal.object_id
  azuread_app_roles = each.value.roles
}