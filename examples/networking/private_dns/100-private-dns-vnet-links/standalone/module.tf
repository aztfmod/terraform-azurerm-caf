module "caf" {
  source                  = "../../../../../"
  global_settings         = var.global_settings
  tags                    = var.tags
  resource_groups         = var.resource_groups
  logged_aad_app_objectId = var.logged_aad_app_objectId
  networking = {
    vnets       = var.vnets
    private_dns = var.private_dns
  }
}

