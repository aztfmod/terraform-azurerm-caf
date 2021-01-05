module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  networking = {
    vnets                             = var.vnets
    private_dns = var.private_dns
  }
}
  
