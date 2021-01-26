module "caf" {
  source          = "../../../../../"
  global_settings = var.global_settings
  tags            = var.tags
  resource_groups = var.resource_groups
  role_mapping    = var.role_mapping

  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
  }
  
  diagnostics = {
    # Get the diagnostics settings of services to create
    diagnostic_log_analytics    = var.diagnostic_log_analytics
  }

  compute = {
    aks_clusters               = var.aks_clusters
    azure_container_registries = var.azure_container_registries
  }

}