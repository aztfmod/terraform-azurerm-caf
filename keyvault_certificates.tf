module "keyvault_certificates" {
  source     = "./modules/security/keyvault_certificate"
  depends_on = [module.keyvaults, module.keyvault_access_policies]

  for_each = local.security.keyvault_certificates

  settings = each.value
  keyvault = try(local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key], local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key])
}

output "keyvault_certificates" {
  value = module.keyvault_certificates
}