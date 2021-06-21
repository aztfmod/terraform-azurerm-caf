resource "azurecaf_name" "this_name" {
  name          = var.settings.action_group_name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_application_insights"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_monitor_action_group" "this" {
  name                = azurecaf_name.this_name.result
  resource_group_name = var.resource_group_name
  short_name          = var.settings.shortname
}