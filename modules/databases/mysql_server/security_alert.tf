
#
# security_alert_policy and server_vulnerability_assessment
#
#

data "azurerm_storage_account" "mysql_security_alert" {
  count = try(var.settings.security_alert_policy.storage_account.key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.threat_detection_policy.storage_account.key].name
  resource_group_name = var.storage_accounts[var.settings.threat_detection_policy.storage_account.key].resource_group_name
}
