resource "azurecaf_name" "ia" {
  name          = var.settings.name
  resource_type = "azurerm_logic_app_integration_account"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
# Last review :  AzureRM version 2.74.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_integration_account
resource "azurerm_logic_app_integration_account" "ia" {
  name                = azurecaf_name.ia.result
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.settings.sku_name
  tags                = merge(local.tags, lookup(var.settings, "tags", {}))
}

