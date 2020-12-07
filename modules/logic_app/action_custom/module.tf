# Resorce type doesn't "azurerm_logic_app_workflow" doesn't exist in azurecaf!!
# resource "azurecaf_name" "integration_service_environment" {
#   name          = var.name
#   resource_type = "azurerm_logic_app_action_http"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_logic_app_action_custom" "action" {
  name         = var.name
  logic_app_id = var.logic_app_id
  body         = var.body
}
