module "caf" {
  source = "../../../../../caf"

  global_settings          = var.global_settings
  resource_groups          = var.resource_groups
  keyvaults                = var.keyvaults
  keyvault_access_policies = var.keyvault_access_policies
  dynamic_keyvault_secrets = var.dynamic_keyvault_secrets
  keyvault_certificate_issuers = var.keyvault_certificate_issuers
}
