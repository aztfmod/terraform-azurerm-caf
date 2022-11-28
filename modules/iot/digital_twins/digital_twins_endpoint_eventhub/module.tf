# naming convention
resource "azurecaf_name" "adteh" {
  name          = var.name
  resource_type = "azurerm_digital_twins_endpoint_eventhub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
# Per options https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_eventhub
resource "azurerm_digital_twins_endpoint_eventhub" "adteh" {
  name                                 = azurecaf_name.adteh.result
  digital_twins_id                     = var.digital_twins_id
  eventhub_primary_connection_string   = var.eventhub_primary_connection_string
  eventhub_secondary_connection_string = var.eventhub_secondary_connection_string
}