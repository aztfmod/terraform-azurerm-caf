resource "azurecaf_name" "laah" {
  name          = var.settings.name
  resource_type = "azurerm_logic_app_action_http"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
# Last review :  AzureRM version 2.74.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_action_http
resource "azurerm_logic_app_action_http" "laah" {
  name         = azurecaf_name.laah.result
  logic_app_id = var.logic_app_id
  method       = var.settings.method
  uri          = var.settings.uri
  body         = try(var.settings.body, null)
  headers      = try(var.settings.headers, null)

  dynamic "run_after" {
    for_each = try(var.settings.run_after, null) != null ? [1] : []

    content {
      action_name   = var.settings.run_after.action_name
      action_result = var.settings.run_after.action_result
    }
  }
}
