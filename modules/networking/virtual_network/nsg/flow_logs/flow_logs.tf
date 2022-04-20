resource "azurerm_network_watcher_flow_log" "flow" {
  count = try(var.settings, {}) == {} ? 0 : 1


  network_watcher_name = try(
    var.network_watchers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.network_watcher_key].name,
    format("NetworkWatcher_%s", var.resource_location)
  )

  resource_group_name = try(
    var.network_watchers[try(var.settings.lz_key, var.client_config.landingzone_key)][var.settings.network_watcher_key].resource_group_name,
    "NetworkWatcherRG"
  )
  name                      = var.settings.name
  version                   = try(var.settings.version, 2)
  network_security_group_id = var.resource_id
  storage_account_id = try(var.diagnostics.diagnostics_destinations.storage[var.settings.storage_account.storage_account_destination][var.resource_location].storage_account_resource_id,
  var.diagnostics.storage_accounts[var.diagnostics.diagnostics_destinations.storage[var.settings.storage_account.storage_account_destination][var.resource_location].storage_account_key].id)
  enabled = try(var.settings.enabled, false)

  retention_policy {
    enabled = try(var.settings.storage_account.retention.enabled, true)
    days    = try(var.settings.storage_account.retention.days, 10)
  }

  dynamic "traffic_analytics" {
    for_each = try(var.settings.traffic_analytics, {}) != {} ? [1] : []
    content {
      enabled               = var.settings.traffic_analytics.enabled
      interval_in_minutes   = try(var.settings.traffic_analytics.interval_in_minutes, null)
      workspace_id          = var.diagnostics.log_analytics[var.diagnostics.diagnostics_destinations.log_analytics[var.settings.traffic_analytics.log_analytics_workspace_destination].log_analytics_key].workspace_id
      workspace_region      = var.resource_location
      workspace_resource_id = var.diagnostics.log_analytics[var.diagnostics.diagnostics_destinations.log_analytics[var.settings.traffic_analytics.log_analytics_workspace_destination].log_analytics_key].id
    }
  }
}
