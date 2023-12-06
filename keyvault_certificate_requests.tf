#
# Evolution of the keyvault_certificate module. Plan is to transition to this module over time.
# configuration breaking change when migration from module keyvault_certificate
#
module "keyvault_certificate_requests" {
  depends_on = [module.keyvault_certificate_issuers, module.domain_name_registrations]
  source     = "./modules/security/keyvault_certificate_request"
  for_each   = local.security.keyvault_certificate_requests

  keyvault_id               = can(each.value.keyvault_id) ? each.value.keyvault_id : local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].id
  keyvault_uri              = can(each.value.keyvault_uri) ? each.value.keyvault_uri : local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].vault_uri
  cert_secret_name          = can(each.value.cert_secret_name) || can(each.value.cert_password_key) == false ? try(each.value.cert_secret_name, null) : var.security.dynamic_keyvault_secrets[each.value.keyvault_key][each.value.cert_password_key].secret_name
  certificate_issuers       = try(var.security.keyvault_certificate_issuers, {})
  settings                  = each.value
  domain_name_registrations = local.combined_objects_domain_name_registrations
  client_config             = local.client_config
  inherit_tags              = local.global_settings.inherit_tags
  tags                      = can(each.value.keyvault_id) ? {} : local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].base_tags
}

output "keyvault_certificate_requests" {
  value = module.keyvault_certificate_requests
}
