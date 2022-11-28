

resource "azurecaf_name" "apim" {
  name          = var.settings.name
  resource_type = "azurerm_api_management_api_operation_tag"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_api_management_api_operation_tag" "apim" {
  api_operation_id = var.api_operation_id
  name             = azurecaf_name.apim.result
  display_name     = try(var.settings.display_name, null)
}