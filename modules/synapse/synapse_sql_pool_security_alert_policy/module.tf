resource "azurerm_synapse_sql_pool_security_alert_policy" "syssap" {
  sql_pool_id                  = can(var.settings.sql_pool.id) ? var.settings.sql_pool.id : var.remote_objects.sql_pool[try(var.settings.sql_pool.lz_key, var.client_config.landingzone_key)][var.settings.sql_pool.key].id
  policy_state                 = var.settings.policy_state
  disabled_alerts              = try(var.settings.disabled_alerts, null)
  email_account_admins_enabled = try(var.settings.email_account_admins_enabled, null)
  email_addresses              = try(var.settings.email_addresses, null)
  retention_days               = try(var.settings.retention_days, null)
  storage_account_access_key   = can(var.settings.storage_accounts.key) == false ? try(var.settings.storage_accounts.access_key, null) : var.remote_objects.storage_accounts[try(var.settings.storage_accounts.lz_key, var.client_config.landingzone_key)][var.settings.storage_accounts.key].primary_access_key
  storage_endpoint             = can(var.settings.storage_accounts.key) == false ? try(var.settings.storage_accounts.endpoint, null) : var.remote_objects.storage_accounts[try(var.settings.storage_accounts.lz_key, var.client_config.landingzone_key)][var.settings.storage_accounts.key].primary_blob_endpoint
}