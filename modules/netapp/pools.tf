module "pools" {
  source   = "./pool"
  for_each = try(var.settings.pools, {})

  global_settings     = var.global_settings
  client_config       = var.client_config
  account_name        = azurerm_netapp_account.account.name
  resource_group_name = azurerm_netapp_account.account.resource_group_name
  location            = azurerm_netapp_account.account.location
  settings            = each.value
  base_tags           = var.base_tags
  vnets               = var.vnets
}
