module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups

  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
  }

  compute = {
    aks_clusters= var.aks_clusters
    virtual_machines  = var.virtual_machines
  }
  
}