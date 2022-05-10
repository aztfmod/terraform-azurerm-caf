resource "azurecaf_name" "backup_vault_policy" {

  name          = var.settings.policy_name
  resource_type = "azurerm_data_protection_backup_policy_disk"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


resource "azurerm_data_protection_backup_policy_disk" "backup_vault_policy" {
  name     = azurecaf_name.backup_vault_policy.result
  vault_id = var.vault_id

  backup_repeating_time_intervals = var.settings.backup_repeating_time_intervals
  default_retention_duration      = var.settings.retention_duration

  dynamic "retention_rule" {
    for_each = try(var.settings.retention_rules, {})
    content {
      name     = retention_rule.value.name
      duration = retention_rule.value.duration
      priority = retention_rule.value.priority
      criteria {
        absolute_criteria = try(retention_rule.value.absolute_criteria, null)
      }
    }
  }
}