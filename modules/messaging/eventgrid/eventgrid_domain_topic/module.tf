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
  domain_name         = coalesce(
                            try(var.remote_objects.eventgrid_domains[var.settings.eventgrid_domain.lz_key][var.settings.eventgrid_domain.key].name,null),
                            try(var.remote_objects.eventgrid_domains[var.client_config.landingzone_key][var.settings.eventgrid_domain.key].name,null),
                            try(var.settings.eventgrid_domain.name,null)
                        )
  resource_group_name = var.resource_group_name
}