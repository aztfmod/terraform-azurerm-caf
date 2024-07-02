resource "azurerm_security_center_storage_defender" "example" {
  count = can(var.storage_account.defender) ? 1 : 0

  storage_account_id                          = azurerm_storage_account.stg.id
  override_subscription_settings_enabled      = try(var.settings.override_subscription_settings, false)
  malware_scanning_on_upload_enabled          = try(var.settings.malware_scanning_on_upload, false)
  malware_scanning_on_upload_cap_gb_per_month = try(var.settings.malware_scanning_on_upload_cap_gb_per_month, -1)
  sensitive_data_discovery_enabled            = try(var.settings.sensitive_data_discovery_enabled, false)
}
