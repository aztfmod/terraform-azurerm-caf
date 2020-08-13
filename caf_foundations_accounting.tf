module "foundations_accounting" {
  source = "./modules/foundations_accounting/"

  for_each = var.accounting_settings

  global_settings     = var.global_settings
  resource_groups     = azurerm_resource_group.rg
  accounting_settings = each.value
}