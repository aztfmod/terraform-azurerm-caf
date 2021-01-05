resource "azurerm_logic_app_action_custom" "action" {
  name         = var.name
  logic_app_id = var.logic_app_id
  body         = var.body
}
