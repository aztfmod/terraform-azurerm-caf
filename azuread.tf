#
# Azure Active Directory Applications
#

module azuread_applications {
  source     = "./modules/azuread/applications"
  depends_on = [module.keyvaults, module.keyvault_access_policies]
  for_each   = var.azuread_apps

  client_config           = local.client_config
  settings                = each.value
  azuread_api_permissions = try(var.azuread_api_permissions[each.key], {})
  global_settings         = local.global_settings
  user_type               = var.user_type
  keyvaults               = module.keyvaults
  tfstates                = var.tfstates
  use_msi                 = var.use_msi
}

output aad_apps {
  value     = module.azuread_applications
  sensitive = true
}


module azuread_app_roles {
  source   = "./modules/azuread/roles"
  for_each = var.azuread_app_roles

  object_id         = module.azuread_applications[each.key].azuread_service_principal.object_id
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