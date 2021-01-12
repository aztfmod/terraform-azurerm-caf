module "caf" {
  source = "../../../../../"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  role_mapping   = var.role_mapping

  networking= {
    vnets= var.vnets
    network_security_group_definition = var.network_security_group_definition
  }

  compute = {
    aks_clusters= var.aks_clusters
    azure_container_registries = var.azure_container_registries
  }
  
}