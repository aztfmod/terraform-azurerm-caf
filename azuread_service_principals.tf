#
# Azure Active Directory Applications
#

module "azuread_service_principals" {
  source     = "./modules/azuread/service_principal"
  for_each   = local.azuread.azuread_service_principals

  client_config           = local.client_config
  global_settings         = local.global_settings
  settings                = each.value
  
  application_id = coalesce(
    try(each.value.azuread_application.application_id, ""),
    try(local.combined_objects_azuread_applications[try(each.value.azuread_application.lz_key,local.client_config.landingzone_key)][each.value.azuread_application.key].application_id, "")
  )
  
}

output "azuread_service_principals" {
  value = module.azuread_service_principals

}
