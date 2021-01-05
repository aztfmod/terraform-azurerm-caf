module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  diagnostic_storage_accounts                  = var.diagnostic_storage_accounts
  diagnostics_definition = var.diagnostics_definition 
  diagnostics_destinations = var.diagnostics_destinations 
  keyvault_certificate_issuers  = var.keyvault_certificate_issuers 
  keyvaults  = var.keyvaults 
  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
    public_ip_addresses               = var.public_ip_addresses
    dns_zones  = var.dns_zones
    front_door_waf_policies = var.front_door_waf_policies
    front_doors  = var.front_doors
  }
  security = {
    dynamic_keyvault_secrets      = var.dynamic_keyvault_secrets
    keyvault_certificate_requests = var.keyvault_certificate_requests
  } 
}
  
