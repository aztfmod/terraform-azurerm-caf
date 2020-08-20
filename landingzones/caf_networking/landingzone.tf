module "landingzones_networking" {
  source = "../.."

  diagnostics     = local.diagnostics
  global_settings = local.global_settings

  resource_groups = var.resource_groups
  networking = {
    vnets                             = var.vnets
    networking_objects                = {}
    vnet_peerings                     = var.vnet_peerings
    network_security_group_definition = var.network_security_group_definition
    firewalls                         = var.firewalls
  }
  storage_accounts   = var.storage_accounts
  virtual_machines   = var.virtual_machines
  managed_identities = var.managed_identities
}