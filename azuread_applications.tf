#
# Azure Active Directory Applications (original version with service principal combined in one object)
#
#
#

# Module for the CAf variable azuread_apps
module "azuread_applications" {
  source     = "./modules/azuread/applications"
  depends_on = [module.keyvault_access_policies]
  for_each   = local.azuread.azuread_apps

  azuread_api_permissions = try(local.azuread.azuread_api_permissions[each.key], {})
  client_config           = local.client_config
  global_settings         = local.global_settings
  keyvaults               = local.combined_objects_keyvaults
  settings                = each.value
  user_type               = var.user_type
}

output "aad_apps" {
  value = module.azuread_applications

}


# Module for the CAf variable azuread_applications
module "azuread_applications_v1" {
  source   = "./modules/azuread/applications_v1"
  for_each = local.azuread.azuread_applications

  azuread_api_permissions = try(local.azuread.azuread_api_permissions[each.key], {})
  client_config           = local.client_config
  global_settings         = local.global_settings
  settings                = each.value
  user_type               = var.user_type
}

output "azuread_applications" {
  value = module.azuread_applications_v1
}
