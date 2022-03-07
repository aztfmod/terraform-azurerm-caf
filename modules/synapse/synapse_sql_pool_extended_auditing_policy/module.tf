resource "azurerm_synapse_sql_pool_extended_auditing_policy" "syspeap" {
  sql_pool_id                             = var.settings.sql_pool_id
  storage_endpoint                        = try(var.settings.storage_endpoint, null)
  retention_in_days                       = try(var.settings.retention_in_days, null)
  storage_account_access_key              = try(var.settings.storage_account_access_key, null)
  storage_account_access_key_is_secondary = try(var.settings.storage_account_access_key_is_secondary, null)
  log_monitoring_enabled                  = try(var.settings.log_monitoring_enabled, null)
}