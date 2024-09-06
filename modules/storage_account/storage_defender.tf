resource "azurerm_security_center_storage_defender" "defender" {
  count = can(var.storage_account.defender) ? 1 : 0

  storage_account_id                          = azurerm_storage_account.stg.id
  override_subscription_settings_enabled      = try(var.storage_account.defender.override_subscription_settings, null)
  malware_scanning_on_upload_enabled          = try(var.storage_account.defender.malware_scanning_on_upload, null)
  malware_scanning_on_upload_cap_gb_per_month = try(var.storage_account.defender.malware_scanning_on_upload_cap_gb_per_month, null)
  sensitive_data_discovery_enabled            = try(var.storage_account.defender.sensitive_data_discovery_enabled, null)
}
