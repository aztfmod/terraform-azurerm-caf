module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups

  shared_services = {
    recovery_vaults  = var.recovery_vaults 
  }
}
  
