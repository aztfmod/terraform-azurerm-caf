# naming convention
resource "azurecaf_name" "adteg" {
  name          = var.name
  resource_type = "azurerm_digital_twins_endpoint_eventgrid"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
# Per options https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_eventhub
resource "azurerm_digital_twins_endpoint_eventgrid" "adteg" {
  name                                 = azurecaf_name.adteg.result
  digital_twins_id                     = var.digital_twins_id
  eventgrid_topic_endpoint             = var.eventgrid_topic_endpoint
  eventgrid_topic_primary_access_key   = var.eventgrid_topic_primary_access_key
  eventgrid_topic_secondary_access_key = var.eventgrid_topic_secondary_access_key
}
