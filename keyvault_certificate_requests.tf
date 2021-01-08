module keyvault_certificate_requests {
  source   = "./modules/security/keyvault_certificate_request"
  for_each = local.security.keyvault_certificate_requests

  keyvault_id         = try(local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key].id, local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key].id)
  certificate_issuers = module.keyvault_certificate_issuers
  settings            = each.value
}