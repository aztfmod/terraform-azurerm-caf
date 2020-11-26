resource "azurerm_network_watcher_flow_log" "flow" {
 
  network_watcher_name      = try(var.settings.network_watcher_name, format("NetworkWatcher_%s",var.resource_location))
  resource_group_name       = try(var.settings.network_watcher_rg_key, "NetworkWatcherRG")
  version                   = try(var.settings.version, 2)
  
  network_security_group_id = var.resource_id
  storage_account_id        = try(var.diagnostics.storage_accounts[var.diagnostics.diagnostics_destinations.storage[var.settings.storage_account.storage_account_destination][var.resource_location].storage_account_key].id)
  
  enabled                   = var.settings.enabled

  retention_policy {
    enabled = try(var.settings.storage_account.retention.enabled, true)
    days    = try(var.settings.storage_account.retention.days, 10)
  }

  traffic_analytics {
    enabled               = lookup(var.settings, "traffic_analytics", {}) != {} ? var.settings.traffic_analytics.enabled : false
    workspace_id          = var.diagnostics.log_analytics[var.diagnostics.diagnostics_destinations.log_analytics[var.settings.traffic_analytics.log_analytics_workspace_destination].log_analytics_key].workspace_id
    workspace_region      = var.resource_location
    workspace_resource_id = var.diagnostics.log_analytics[var.diagnostics.diagnostics_destinations.log_analytics[var.settings.traffic_analytics.log_analytics_workspace_destination].log_analytics_key].id
  }
}