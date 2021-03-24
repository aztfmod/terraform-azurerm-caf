resource "azurerm_logic_app_action_http" "action" {
  name         = var.name
  logic_app_id = var.logic_app_id
  method       = var.method
  uri          = var.uri
  body         = try(var.body, null)
  headers      = try(var.headers, null)

  dynamic "run_after" {
    for_each = try(var.run_after, null) != null ? [1] : []

    content {
      action_name   = var.run_after.action_name
      action_result = var.run_after.action_result
    }
  }
}
