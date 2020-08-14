module keyvault_access_policies {
  source = "/tf/caf/modules/security/keyvault_access_policy"
  for_each             = var.keyvault_access_policies

  keyvault_id          = module.keyvault[each.key].id
  access_policies      = each.value
  azuread_groups       = module.azuread_groups
  # azuread_apps         = module.azuread_applications
  logged_user_objectId = var.logged_user_objectId
}