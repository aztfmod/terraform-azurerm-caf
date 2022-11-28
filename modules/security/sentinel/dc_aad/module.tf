resource "azurerm_sentinel_data_connector_azure_active_directory" "dc_aad" {
  name                       = var.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  tenant_id                  = var.tenant_id
}
