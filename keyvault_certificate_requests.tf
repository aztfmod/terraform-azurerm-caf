#
# Evolution of the keyvault_certificate module. Plan is to transition to this module over time.
# configuration breaking change when migration from module keyvault_certificate
#
module "keyvault_certificate_requests" {
  depends_on = [module.keyvault_certificate_issuers, module.domain_name_registrations]
  source     = "./modules/security/keyvault_certificate_request"
  for_each   = local.security.keyvault_certificate_requests

  global_settings           = local.global_settings
  base_tags                 = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  keyvault_id               = can(each.value.keyvault_id) ? each.value.keyvault_id : local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].id
  certificate_issuers       = try(var.security.keyvault_certificate_issuers, {})
  settings                  = each.value
  domain_name_registrations = local.combined_objects_domain_name_registrations
  client_config             = local.client_config
}

output "keyvault_certificate_requests" {
  value = module.keyvault_certificate_requests
}
