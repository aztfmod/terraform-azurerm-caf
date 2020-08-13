module "keyvault" {
  source = "/tf/caf"

  global_settings = var.global_settings
  resource_groups = var.resource_groups
  keyvaults       = var.keyvaults
  # networking      = var.vnets
}