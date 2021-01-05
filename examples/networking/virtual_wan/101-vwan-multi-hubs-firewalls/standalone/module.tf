module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  resource_groups  = var.resource_groups
  tags               = var.tags
  networking = {
    vnets  = var.vnets
    virtual_wans = var.virtual_wans


  }
}
  
