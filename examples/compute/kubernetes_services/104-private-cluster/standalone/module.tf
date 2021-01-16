module "caf" {
  source             = "../../../../../"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  role_mapping       = var.role_mapping
  managed_identities = var.managed_identities
  storage_accounts   = var.storage_accounts
  keyvaults          = var.keyvaults

  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
    vnet_peerings                     = var.vnet_peerings
  }

  compute = {
    aks_clusters               = var.aks_clusters
    azure_container_registries = var.azure_container_registries
    virtual_machines           = var.virtual_machines
  }

}