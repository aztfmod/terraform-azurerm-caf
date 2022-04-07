resource "azurerm_sentinel_data_connector_office_365" "dc_office_365" {
  name                       = var.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  tenant_id                  = var.tenant_id
  exchange_enabled           = var.exchange_enabled
  sharepoint_enabled         = var.sharepoint_enabled
  teams_enabled              = var.teams_enabled
}
