resource "azurerm_api_management_api_operation_policy" "apim" {
  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  operation_id = coalesce(
    try(var.remote_objects.api_management_api_operation[var.client_config.landingzone_key][var.settings.api_operation.key].id, null),
    try(var.remote_objects.api_management_api_operation[var.settings.api_operation.lz_key][var.settings.api_operation.key].id, null),
    try(var.settings.api_operation.id, null)
  )
  xml_content = try(var.settings.xml_content, null)
  xml_link    = try(var.settings.xml_link, null)
}