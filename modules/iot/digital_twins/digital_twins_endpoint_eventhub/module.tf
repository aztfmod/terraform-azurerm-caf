# Per options https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/digital_twins_endpoint_eventhub
resource "azurerm_digital_twins_endpoint_eventhub" "ev" {
  name                                 = var.name
  digital_twins_id                     = var.digital_twins_id
  eventhub_primary_connection_string   = var.eventhub_primary_connection_string
  eventhub_secondary_connection_string = var.eventhub_secondary_connection_string
}