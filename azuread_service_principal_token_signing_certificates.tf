module "azuread_service_principal_token_signing_certificates" {
  source   = "./modules/azuread/service_principal_token_signing_certificate"
  for_each = local.azuread.azuread_service_principal_token_signing_certificates

  settings             = each.value
  service_principal_id = can(each.value.azuread_service_principal.id) ? each.value.azuread_service_principal.id : local.combined_objects_azuread_service_principals[try(each.value.azuread_service_principal.lz_key, local.client_config.landingzone_key)][each.value.azuread_service_principal.key].id
}

output "azuread_service_principal_token_signing_certificates" {
  value = module.azuread_service_principal_token_signing_certificates
}
