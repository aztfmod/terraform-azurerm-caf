resource "azurerm_backup_policy_vm_workload" "sql" {
  for_each = try(var.settings.backup_policies.sql, {})

  name                = each.value.name
  resource_group_name = local.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.asr.name
  workload_type       = each.value.workload_type

  settings {
    time_zone           = each.value.timezone
    compression_enabled = each.value.compression_enabled
  }

  protection_policy {
    policy_type = each.value.policy_type

    dynamic "backup" {
      for_each = lookup(each.value, "backup", null) == null ? [] : [1]

      content {
        frequency            = try(each.value.backup.frequency, null)
        frequency_in_minutes = try(each.value.backup.frequency_in_minutes, null)
        time                 = try(each.value.backup.time, null)
        weekdays             = try(each.value.weekdays.time, null)
      }
    }

    dynamic "retention_daily" {
      for_each = lookup(each.value, "retention_daily", null) == null ? [] : [1]

      content {
        count = each.value.retention_daily.count
      }
    }

    dynamic "retention_weekly" {
      for_each = lookup(each.value, "retention_weekly", null) == null ? [] : [1]

      content {
        count    = each.value.retention_weekly.count
        weekdays = each.value.retention_weekly.weekdays
      }
    }

    dynamic "retention_monthly" {
      for_each = lookup(each.value, "retention_monthly", null) == null ? [] : [1]

      content {
        count       = each.value.retention_monthly.count
        format_type = each.value.retention_monthly.format_type
        monthdays   = try(each.value.backup.monthdays, null)
        weekdays    = try(each.value.backup.weekdays, null)
        weeks       = try(each.value.backup.weeks, null)
      }
    }

    dynamic "retention_yearly" {
      for_each = lookup(each.value, "retention_yearly", null) == null ? [] : [1]

      content {
        count       = each.value.retention_yearly.count
        format_type = each.value.retention_yearly.format_type
        months      = each.value.retention_yearly.months
        monthdays   = try(each.value.backup.monthdays, null)
        weekdays    = try(each.value.weekdays.monthdays, null)
        weeks       = try(each.value.weeks.monthdays, null)
      }
    }

    dynamic "simple_retention" {
      for_each = lookup(each.value, "simple_retention", null) == null ? [] : [1]

      content {
        count = each.value.simple_retention.count
      }
    }
  }
}
