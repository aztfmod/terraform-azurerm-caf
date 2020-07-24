module "caf" {
  source = "../.."

  prefix                      = local.prefix
  prefix_with_hyphen          = local.prefix_with_hyphen
  caf_foundations_accounting  = local.caf_foundations_accounting
  caf_foundations_security    = local.caf_foundations_security
  global_settings             = local.global_settings

  resource_groups = var.resource_groups
  networking      = var.vnets
  firewalls       = var.firewalls
  storage_accounts = var.storage_accounts
  virtual_machines = var.virtual_machines
  managed_identities = var.managed_identities
}