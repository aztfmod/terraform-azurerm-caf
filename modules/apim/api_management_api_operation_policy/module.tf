resource "azurerm_api_management_api_operation_policy" "apim" {
  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  operation_id        = var.settings.api_operation_id
  xml_content         = try(var.settings.xml_content, null)
  xml_link            = try(var.settings.xml_link, null)
}