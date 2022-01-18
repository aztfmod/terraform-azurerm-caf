resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_data_factory" #"azurerm_api_management_api"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_api_management_gateway_api" "apim" {


  gateway_id = coalesce(
    try(var.remote_objects.api_management_gateway[var.settings.api_management_gateway.lz_key][var.settings.api_management_gateway.key].id, null),
    try(var.remote_objects.api_management_gateway[var.client_config.landingzone_key][var.settings.api_management_gateway.key].id, null),
    try(var.settings.api_management_gateway.id, null)
  )

  api_id = coalesce(
    try(var.remote_objects.api_management_api[var.settings.api_management_api.lz_key][var.settings.api_management_api.key].id, null),
    try(var.remote_objects.api_management_api[var.client_config.landingzone_key][var.settings.api_management_api.key].id, null),
    try(var.settings.api_management_api.id, null)
  )

  dynamic "timeouts" {
    for_each = try(var.settings.timeouts, null) != null ? [var.settings.timeouts] : []
    content {
      create = try(timeouts.value.create, null)
      read = try(timeouts.value.read, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
