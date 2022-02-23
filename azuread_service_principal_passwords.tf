#
# Azure Active Directory Applications
#

module "azuread_service_principal_passwords" {
  source     = "./modules/azuread/service_principal_password"
  depends_on = [module.keyvault_access_policies]
  for_each   = local.azuread.azuread_service_principal_passwords

  client_config   = local.client_config
  global_settings = local.global_settings
  keyvaults       = local.combined_objects_keyvaults
  settings        = each.value

  service_principal_id = coalesce(
    try(each.value.azuread_service_principal.id, ""),
    try(local.combined_objects_azuread_service_principals[try(each.value.azuread_service_principal.lz_key, local.client_config.landingzone_key)][each.value.azuread_service_principal.key].id, "")
  )

  service_principal_application_id = coalesce(
    try(each.value.azuread_service_principal.application_id, ""),
    try(local.combined_objects_azuread_service_principals[try(each.value.azuread_service_principal.lz_key, local.client_config.landingzone_key)][each.value.azuread_service_principal.key].application_id, "")
  )

}

output "azuread_service_principal_passwords" {
  value = module.azuread_service_principal_passwords
}
