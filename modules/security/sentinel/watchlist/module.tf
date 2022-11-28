resource "azurerm_sentinel_watchlist" "watchlist" {
  name                       = var.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  display_name               = var.display_name
  default_duration           = var.default_duration
  description                = var.description
  labels                     = var.labels
}
