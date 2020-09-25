# Server auditing

data "azurerm_storage_account" "mssqldb_auditing" {
  count = try(var.settings.extended_auditing_policy.storage_account.key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.extended_auditing_policy.storage_account.key].name
  resource_group_name = var.storage_accounts[var.settings.extended_auditing_policy.storage_account.key].resource_group_name
}

resource "azurerm_mssql_server_extended_auditing_policy" "mssqldb" {
  count = try(var.settings.extended_auditing_policy, null) == null ? 0 : 1

  server_id                               = var.server_id
  storage_endpoint                        = data.azurerm_storage_account.mssqldb_auditing.0.primary_blob_endpoint
  storage_account_access_key              = data.azurerm_storage_account.mssqldb_auditing.0.primary_access_key
  storage_account_access_key_is_secondary = try(var.settings.extended_auditing_policy.storage_account_access_key_is_secondary, false)
  retention_in_days                       = try(var.settings.extended_auditing_policy.retention_in_days, null)
}