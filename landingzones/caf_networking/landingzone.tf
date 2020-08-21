module "landingzones_networking" {
  source = "../.."

  tags            = local.tags
  diagnostics     = local.diagnostics
  global_settings = local.global_settings

  resource_groups = var.resource_groups
  networking = {
    vnets                             = var.vnets
    networking_objects                = {}
    vnet_peerings                     = var.vnet_peerings
    network_security_group_definition = var.network_security_group_definition
    azurerm_firewalls                 = var.azurerm_firewalls
    public_ip_addresses               = var.public_ip_addresses
  }
  compute = {
    virtual_machines = var.virtual_machines
    bastion_hosts    = {}
  }
  storage_accounts   = var.storage_accounts
  managed_identities = var.managed_identities
}