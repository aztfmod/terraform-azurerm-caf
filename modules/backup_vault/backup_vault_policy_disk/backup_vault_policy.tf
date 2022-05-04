resource "azurerm_data_protection_backup_policy_disk" "backup_vault_policy" {
  name     = var.settings.policy_name
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