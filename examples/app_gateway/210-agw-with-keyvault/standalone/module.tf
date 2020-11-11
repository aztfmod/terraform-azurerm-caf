module "caf" {
  source = "/tf/caf/aztfmod/es"

  global_settings          = var.global_settings
  resource_groups          = var.resource_groups
  storage_accounts         = var.storage_accounts
  keyvaults                = var.keyvaults
  keyvault_access_policies = var.keyvault_access_policies
  managed_identities       = var.managed_identities
  role_mapping             = var.role_mapping
  security = {
    keyvault_certificates = var.keyvault_certificates
  }
  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
    public_ip_addresses               = var.public_ip_addresses
    application_gateways              = var.application_gateways
    application_gateway_applications  = var.application_gateway_applications
  }
}
