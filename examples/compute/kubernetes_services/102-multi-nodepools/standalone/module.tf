module "caf" {
  source          = "../../../../../"
  global_settings = var.global_settings
  tags            = var.tags
  resource_groups = var.resource_groups

  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
  }

  diagnostics = {
    # Get the diagnostics settings of services to create
    diagnostic_log_analytics = var.diagnostic_log_analytics
  }

  compute = {
    aks_clusters     = var.aks_clusters
    virtual_machines = var.virtual_machines
  }

}