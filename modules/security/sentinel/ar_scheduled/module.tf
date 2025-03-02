resource "azurerm_sentinel_alert_rule_scheduled" "scheduled" {
  name                       = var.name
  log_analytics_workspace_id = var.log_analytics_workspace_id
  display_name               = var.display_name
  severity                   = var.severity
  query                      = var.query
  alert_rule_template_guid   = var.alert_rule_template_guid
  description                = var.description
  enabled                    = var.enabled
  query_frequency            = var.query_frequency
  query_period               = var.query_period
  suppression_duration       = var.suppression_duration
  suppression_enabled        = var.suppression_enabled
  tactics                    = var.tactics
  trigger_operator           = var.trigger_operator
  trigger_threshold          = var.trigger_threshold

  dynamic "event_grouping" {
    for_each = lookup(var.settings, "event_grouping", {}) != {} ? [1] : []

    content {
      aggregation_method = lookup(var.settings.event_grouping, "aggregation_method", null)
    }
  }

  dynamic "incident" {
    for_each = lookup(var.settings, "incident", {}) != {} ? [1] : []

    content {
      create_incident_enabled = lookup(var.settings.incident, "create_incident_enabled", null)

      dynamic "grouping" {
        for_each = lookup(var.settings.incident, "grouping", {}) != {} ? [1] : []

        content {
          enabled                 = lookup(var.settings.incident.grouping, "enabled", true)
          lookback_duration       = lookup(var.settings.incident.grouping, "lookback_duration", "PT5M")
          reopen_closed_incidents = lookup(var.settings.incident.grouping, "reopen_closed_incidents", false)
          entity_matching_method  = lookup(var.settings.incident.grouping, "entity_matching_method", null)
          by_entities       = lookup(var.settings.incident.grouping, "by_entities", null)
          by_alert_details  = lookup(var.settings.incident.grouping, "by_alert_details", null)
          by_custom_details = lookup(var.settings.incident.grouping, "by_custom_details", null)
        }
      }
    }
  }
}
