module azuread_users {
  source     = "/tf/caf/modules/azuread/users"
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