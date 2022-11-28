resource "azurerm_sentinel_alert_rule_ms_security_incident" "security_incident" {
  name                        = var.name
  log_analytics_workspace_id  = var.log_analytics_workspace_id
  display_name                = var.display_name
  product_filter              = var.product_filter
  severity_filter             = var.severity_filter
  alert_rule_template_guid    = var.alert_rule_template_guid
  description                 = var.description
  enabled                     = var.enabled
  display_name_filter         = var.display_name_filter
  display_name_exclude_filter = var.display_name_exclude_filter
}
