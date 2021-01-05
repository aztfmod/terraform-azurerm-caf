module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  networking = {
    vnets  = var.vnets
    dns_zones                            = var.dns_zones
  }
}
  
