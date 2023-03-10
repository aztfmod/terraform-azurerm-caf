resource "azurecaf_name" "appiwt" {
  name          = var.name
  resource_type = "azurerm_application_insights_web_test"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_application_insights_web_test" "appiwt" {
  name                    = azurecaf_name.appiwt.result
  location                = var.location
  resource_group_name     = var.resource_group_name
  application_insights_id = var.application_insights_id
  kind                    = var.settings.kind
  geo_locations           = var.settings.geo_locations
  configuration           = var.settings.configuration
  frequency               = try(var.settings.frequency, null)
  timeout                 = try(var.settings.timeout, null)
  enabled                 = try(var.settings.enabled)
  retry_enabled           = try(var.settings.retry_enabled, null)
  description             = try(var.settings.description, null)
  tags                    = local.tags
}