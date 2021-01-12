module "caf" {
  source = "../../../../../"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  keyvaults  = var.keyvaults

  networking = {
    vnets                             = var.vnets
  }

  compute = {
    proximity_placement_groups= var.proximity_placement_groups
    virtual_machines  = var.virtual_machines
  }
  
}