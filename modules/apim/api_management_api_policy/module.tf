resource "azurerm_api_management_api_policy" "apim" {
  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  xml_content         = try(var.settings.xml_content, null)
  xml_link            = try(var.settings.xml_link, null)
}