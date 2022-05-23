resource "azurerm_api_management_group_user" "apim" {
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  group_name          = var.group_name
  user_id             = var.user_id
           
}