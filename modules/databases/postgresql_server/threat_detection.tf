# threat detection policy

data "azurerm_storage_account" "postgresql_va" {
  count = try(var.settings.threat_detection_policy.storage_account_key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.threat_detection_policy.storage_account_key].name
  resource_group_name = var.storage_accounts[var.settings.threat_detection_policy.storage_account_key].resource_group_name
}


