module keyvault_access_policies {
  source   = "./modules/security/keyvault_access_policy"
  for_each = var.keyvault_access_policies

  keyvault_id          = module.keyvaults[each.key].id
  access_policies      = each.value
  azuread_groups       = module.azuread_groups
  logged_user_objectId = var.logged_user_objectId
}