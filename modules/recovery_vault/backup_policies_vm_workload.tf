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

      content {}
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
      for_each = each.value.retention_monthly.format_type == "Daily" ? [1] : []
      content {
        count       = each.value.retention_monthly.count
        format_type = each.value.retention_monthly.format_type
      }
    }

    dynamic "retention_yearly" {
      for_each = lookup(each.value, "retention_yearly", null) == null ? [] : [1]

      content {
        count       = each.value.retention_yearly.count
        format_type = each.value.retention_yearly.format_type
        months      = each.value.retention_yearly.months
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
