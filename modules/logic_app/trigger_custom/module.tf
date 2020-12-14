resource "azurerm_logic_app_trigger_custom" "trigger" {
  name         = var.name
  logic_app_id = var.logic_app_id
  body         = var.body
}
