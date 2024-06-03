
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
      read   = try(timeouts.value.read, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}