
module "compute" {
  source             = "./modules/terraform-azurerm-caf-compute"
  global_settings    = local.global_settings
  resource_groups    = azurerm_resource_group.rg
  compute            = var.compute
  vnets              = local.vnets
  managed_identities = azurerm_user_assigned_identity.msi
  storage_accounts   = module.storage_accounts
}
