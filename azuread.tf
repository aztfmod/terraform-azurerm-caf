#
# Azure Active Directory Applications
#

module azuread_applications {
  source     = "./modules/terraform-azuread-caf-aad-apps"
  depends_on = [module.keyvault_access_policies]

  azuread_apps            = var.azuread_apps
  azuread_api_permissions = var.azuread_api_permissions
  keyvaults               = module.keyvaults
  prefix                  = local.global_settings.prefix
  tfstates                = var.tfstates
}


module azuread_app_roles {
  source   = "./modules/azuread/roles"
  for_each = var.azuread_app_roles

  object_id         = module.azuread_applications.aad_apps[each.key].azuread_service_principal.object_id
  azuread_app_roles = each.value.roles
}

#
# Azure Active Directory Groups
#

module azuread_groups {
  source   = "./modules/azuread/groups"
  for_each = var.azuread_groups

  global_settings = local.global_settings
  azuread_groups  = each.value
}

output azuread_groups {
  value     = module.azuread_groups
  sensitive = true
}

#
# Azure Active Directory Users
#

module azuread_users {
  source     = "./modules/azuread/users"
  depends_on = [module.keyvault_access_policies]
  for_each   = var.azuread_users

  global_settings = local.global_settings
  azuread_users   = each.value
  keyvaults       = module.keyvaults
}

output azuread_users {
  value     = module.azuread_users
  sensitive = true
}