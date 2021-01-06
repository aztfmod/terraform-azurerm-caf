module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  keyvaults  = var.keyvaults

  networking = {
    vnets                             = var.vnets
  }

  compute = {
    availability_sets = var.availability_sets
    virtual_machines  = var.virtual_machines
  }
  
}