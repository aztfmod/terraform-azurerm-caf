resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_api_management_logger"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_api_management_logger" "apim" {
  name = azurecaf_name.apim.result

  resource_group_name = var.resource_group_name

  api_management_name = var.api_management_name

  application_insights {
    instrumentation_key = try(
      var.remote_objects.application_insights[var.settings.application_insights.lz_key][var.settings.application_insights.key].instrumentation_key,
      var.remote_objects.application_insights[var.client_config.landingzone_key][var.settings.application_insights.key].instrumentation_key,
      var.settings.application_insights.instrumentation_key,
    null)
  }
  buffered = try(var.settings.buffered, null)

  description = try(var.settings.description, null)

  dynamic "eventhub" {
    for_each = try(var.settings.eventhub, null) != null ? [var.settings.eventhub] : []
    content {
      name              = try(eventhub.value.name, null)
      connection_string = try(eventhub.value.connection_string, null)
    }
  }
  resource_id = try(var.settings.resource_id, null)

}