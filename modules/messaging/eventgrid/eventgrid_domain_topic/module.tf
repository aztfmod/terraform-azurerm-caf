resource "azurecaf_name" "egdt" {
  name          = var.settings.name
  resource_type = "azurerm_eventgrid_domain_topic"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_eventgrid_domain_topic" "egdt" {
  name                = azurecaf_name.egdt.result
  domain_name         = can(var.settings.eventgrid_domain.name) ? var.settings.eventgrid_domain.name : var.remote_objects.eventgrid_domains[try(var.settings.eventgrid_domain.lz_key, var.client_config.landingzone_key)][var.settings.eventgrid_domain.key].name
  resource_group_name = can(var.settings.resource_group.name) ? var.settings.resource_group.name : var.remote_objects.resource_group[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name
}