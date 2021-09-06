resource "azurecaf_name" "laachr" {
  name          = var.settings.name
  resource_type = "azurerm_logic_app_trigger_http_request"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_logic_app_trigger_http_request" "laachr" {
  name          = azurecaf_name.laachr.result
  logic_app_id  = var.logic_app_id
  schema        = var.settings.schema
  method        = try(var.settings.method, null)
  relative_path = try(var.settings.relative_path, null)
}
