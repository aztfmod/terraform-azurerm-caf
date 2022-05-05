resource "azurecaf_name" "backup_vault_policy" {
  name          = var.settings.policy_name
  resource_type = "azurerm_data_protection_backup_policy_blob_storage"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_data_protection_backup_policy_blob_storage" "backup_vault_policy" {
  name               = azurecaf_name.backup_vault_policy.result
  vault_id           = var.vault_id
  retention_duration = var.settings.retention_duration
}
