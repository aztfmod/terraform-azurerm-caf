resource "azurecaf_name" "latc" {
  name          = var.settings.name
  resource_type = "azurerm_logic_app_trigger_custom"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
# Last review :  AzureRM version 2.74.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_trigger_custom
resource "azurerm_logic_app_trigger_custom" "latc" {
  name         = azurecaf_name.latc.result
  logic_app_id = var.logic_app_id
  body         = var.settings.body
}

