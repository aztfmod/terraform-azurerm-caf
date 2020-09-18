
#
# security_alert_policy and server_vulnerability_assessment
#
#

data "azurerm_storage_account" "mssql_security_alert" {
  count = try(var.settings.security_alert_policy.storage_account.key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.security_alert_policy.storage_account.key].name
  resource_group_name = var.storage_accounts[var.settings.security_alert_policy.storage_account.key].resource_group_name
}


resource "azurerm_mssql_server_security_alert_policy" "mssql" {
  count = try(var.settings.security_alert_policy, null) == null ? 0 : 1

  resource_group_name        = var.resource_group_name
  server_name                = azurerm_mssql_server.mssql.name
  state                      = try(var.settings.state, "Enabled")
  storage_endpoint           = data.azurerm_storage_account.mssql_security_alert.0.primary_blob_endpoint
  storage_account_access_key = data.azurerm_storage_account.mssql_security_alert.0.primary_access_key
  disabled_alerts            = try(var.settings.disabled_alerts, null)
  email_account_admins       = try(var.settings.email_subscription_admins, false)
  email_addresses            = try(var.settings.email_addresses, null)
  retention_days             = try(var.settings.retention_days, 0)
}