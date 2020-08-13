resource "azurerm_monitor_diagnostic_setting" "diagnostics" {

  # for_each           = var.diagnostics
  name               = var.diagnostics.name
  target_resource_id = var.resource_id

  #  eventhub_name                    = lookup(var.diagnostics, "eh_name", null)
  #  eventhub_authorization_rule_id   = lookup(var.diagnostics, "eh_id", null) != null ? "${var.diagnostics.eh_id}/authorizationrules/RootManageSharedAccessKey" : null

  log_analytics_workspace_id     = lookup(var.diagnostics.destinations, "log_analytics", null) == null ? null : var.log_analytics[var.diagnostics.destinations.log_analytics.log_analytics_key].id
  log_analytics_destination_type = lookup(var.diagnostics.destinations, "log_analytics_destination_type", null)
  storage_account_id             = lookup(var.diagnostics.destinations, "storage", null) == null ? null : var.storage_accounts[var.diagnostics.destinations.storage[var.resource_location].storage_account_key].id

  dynamic "log" {
    for_each = lookup(var.diagnostics.categories, "log", {})
    content {
      category = log.value[0]
      enabled  = log.value[1]

      dynamic "retention_policy" {
        for_each = length(log.value) > 2 ? [1] : []
        content {
          enabled = log.value[2]
          days    = log.value[3]
        }
      }
    }
  }

  dynamic "metric" {
    for_each = lookup(var.diagnostics.categories, "metric", {})
    content {
      category = metric.value[0]
      enabled  = metric.value[1]

      dynamic "retention_policy" {
        for_each = length(metric.value) > 2 ? [1] : []
        content {
          enabled = metric.value[2]
          days    = metric.value[3]
        }
      }
    }
  }
}  