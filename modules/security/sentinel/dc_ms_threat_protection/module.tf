resource "azurerm_sentinel_data_connector_microsoft_defender_advanced_threat_protection" "dc_ms_threat_protection" {
  name                       = var.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  tenant_id                  = var.tenant_id
}
