module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  keyvaults  = var.keyvaults

  networking = {
    front_door_waf_policies = var.front_door_waf_policies
    front_doors  = var.front_doors
  }

}
  
