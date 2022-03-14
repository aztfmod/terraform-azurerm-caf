resource "azurerm_sentinel_data_connector_azure_security_center" "dc_sc" {
  name                       = var.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  subscription_id            = var.subscription_id
}
