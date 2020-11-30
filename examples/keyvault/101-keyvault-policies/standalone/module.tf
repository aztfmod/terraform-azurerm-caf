module "caf" {
  source = "../../../../"

  global_settings             = var.global_settings
  resource_groups             = var.resource_groups
  keyvaults                   = var.keyvaults
  keyvault_access_policies    = var.keyvault_access_policies

  networking = {
    vnets                             = var.vnets
  }
}
