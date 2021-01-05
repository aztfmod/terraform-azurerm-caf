module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  storage_accounts  = var.storage_accounts
  networking = {
    vnets = var.vnets
    private_endpoints =var.private_endpoints 
  }

}
  
