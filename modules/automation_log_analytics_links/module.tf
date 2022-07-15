resource "azurerm_log_analytics_linked_service" "linked_service" {
  resource_group_name = var.resource_group_name
  workspace_id        = var.workspace_id
  read_access_id      = var.read_access_id
  write_access_id     = var.write_access_id
}