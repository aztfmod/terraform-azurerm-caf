resource "azurerm_api_management_product_group" "apim" {
  product_id          = var.product_id
  group_name          = var.group_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
}