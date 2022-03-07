resource "azurerm_synapse_sql_pool_security_alert_policy" "syssap" {
  sql_pool_id                  = var.settings.sql_pool_id
  policy_state                 = var.settings.policy_state
  disabled_alerts              = try(var.settings.disabled_alerts, null)
  email_account_admins_enabled = try(var.settings.email_account_admins_enabled, null)
  email_addresses              = try(var.settings.email_addresses, null)
  retention_days               = try(var.settings.retention_days, null)
  storage_account_access_key   = try(var.settings.storage_account_access_key, null)
  storage_endpoint             = try(var.settings.storage_endpoint, null)
}