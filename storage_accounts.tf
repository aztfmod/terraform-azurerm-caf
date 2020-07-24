
module "storage_accounts" {
  source = "./modules/storage_account"

  for_each = var.storage_accounts

  global_settings           = var.global_settings
  storage_account           = each.value
  resource_groups           = azurerm_resource_group.rg
}
