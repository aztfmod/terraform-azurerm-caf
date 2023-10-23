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
      for_each = each.value.backup.frequency == "Daily" ? [1] : []

      content {
        frequency            = each.value.backup.frequency
        frequency_in_minutes = each.value.backup.frequency_in_minutes
        time                 = each.value.backup.time
      }
    }

    dynamic "backup" {
      for_each = each.value.backup.frequency == "Weekly" ? [1] : []

      content {
        frequency            = each.value.backup.frequency
        frequency_in_minutes = each.value.backup.frequency_in_minutes
        time                 = each.value.backup.time
        weekdays             = each.value.backup.weekdays
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
      for_each = each.value.retention_monthly != null && each.value.retention_monthly.format_type == "Daily" ? [1] : []

      content {
        count       = each.value.retention_monthly.count
        format_type = each.value.retention_monthly.format_type
        monthdays   = each.value.retention_monthly.monthdays
      }
    }

    dynamic "retention_monthly" {
      for_each = each.value.retention_monthly != null && each.value.retention_monthly.format_type == "Weekly" ? [1] : []

      content {
        count       = each.value.retention_monthly.count
        format_type = each.value.retention_monthly.format_type
        weekdays    = each.value.retention_monthly.weekdays
        weeks       = each.value.retention_monthly.weeks
      }
    }

    dynamic "retention_yearly" {
      for_each = each.value.retention_yearly != null && each.value.retention_yearly.format_type == "Daily" ? [1] : []

      content {
        count       = each.value.retention_yearly.count
        format_type = each.value.retention_yearly.format_type
        monthdays   = each.value.retention_yearly.monthdays
        months      = each.value.retention_yearly.months
      }
    }

    dynamic "retention_yearly" {
      for_each = each.value.retention_yearly != null && each.value.retention_yearly.format_type == "Weekly" ? [1] : []

      content {
        count       = each.value.retention_yearly.count
        format_type = each.value.retention_yearly.format_type
        weekdays    = each.value.retention_yearly.weekdays
        weeks       = each.value.retention_yearly.weeks
        months      = each.value.retention_yearly.months
      }
    }

    # dynamic "retention_monthly" {
    #   for_each = lookup(each.value, "retention_monthly", null) == null ? [] : [1]

    #   content {
    #     count       = each.value.retention_monthly.count
    #     format_type = each.value.retention_monthly.format_type
    #     monthdays   = each.value.retention_monthly.monthdays
    #     weekdays    = each.value.retention_monthly.weekdays
    #     weeks       = each.value.retention_monthly.weeks
    #   }
    # }

    # dynamic "retention_yearly" {
    #   for_each = lookup(each.value, "retention_yearly", null) == null ? [] : [1]

    #   content {
    #     count       = each.value.retention_yearly.count
    #     format_type = each.value.retention_yearly.format_type
    #     months      = each.value.retention_yearly.months
    #     monthdays   = each.value.retention_yearly.monthdays
    #     weekdays    = each.value.retention_yearly.weekdays
    #     weeks       = each.value.retention_yearly.weeks
    #   }
    # }

    dynamic "simple_retention" {
      for_each = lookup(each.value, "simple_retention", null) == null ? [] : [1]

      content {
        count = each.value.simple_retention.count
      }
    }
  }
}
