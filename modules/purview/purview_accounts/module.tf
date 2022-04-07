resource "azurecaf_name" "pva" {
  name          = var.settings.name
  resource_type = "azurerm_purview_account"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_purview_account" "pva" {
  location                    = var.location
  name                        = azurecaf_name.pva.result
  resource_group_name         = var.resource_group_name
  public_network_enabled      = try(var.settings.public_network_enabled, null)
  managed_resource_group_name = try(var.settings.managed_resource_group_name, null)
  tags                        = local.tags
}