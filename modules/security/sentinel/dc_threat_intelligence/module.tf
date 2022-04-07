resource "azurerm_sentinel_data_connector_threat_intelligence" "dc_threat_intelligence" {
  name                       = var.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  tenant_id                  = var.tenant_id
}
