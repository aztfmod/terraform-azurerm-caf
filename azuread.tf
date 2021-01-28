#
# Azure Active Directory Applications
#

module azuread_applications {
  source     = "./modules/azuread/applications"
  depends_on = [module.keyvault_access_policies]
  for_each   = var.azuread_apps

  azuread_api_permissions = try(var.azuread_api_permissions[each.key], {})
  client_config           = local.client_config
  global_settings         = local.global_settings
  keyvaults               = local.combined_objects_keyvaults
  settings                = each.value
  user_type               = var.user_type
}

output aad_apps {
  value = module.azuread_applications

}

#
# Azure Active Directory Groups
#

module azuread_groups {
  source   = "./modules/azuread/groups"
  for_each = var.azuread_groups

  global_settings = local.global_settings
  azuread_groups  = each.value
  tenant_id       = local.client_config.tenant_id
}

output azuread_groups {
  value = module.azuread_groups

}

module azuread_groups_members {
  source   = "./modules/azuread/groups_members"
  for_each = var.azuread_groups

  settings       = each.value
  azuread_groups = module.azuread_groups
  group_id       = module.azuread_groups[each.key].id
  azuread_apps   = module.azuread_applications
}

#
# Azure Active Directory Users
#

module azuread_users {
  source     = "./modules/azuread/users"
  depends_on = [module.keyvault_access_policies]
  for_each   = var.azuread_users

  client_config   = local.client_config
  global_settings = local.global_settings
  keyvaults       = local.combined_objects_keyvaults
  settings        = each.value
}

output azuread_users {
  value = module.azuread_users

}