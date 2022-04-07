resource "azurerm_sentinel_data_connector_microsoft_cloud_app_security" "dc_app_security" {
  name                       = var.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  tenant_id                  = var.tenant_id
  alerts_enabled             = var.alerts_enabled
  discovery_logs_enabled     = var.discovery_logs_enabled
}
