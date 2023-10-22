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
      for_each = lookup(each.value, "retention_daily", null) == "Daily" ? [] : [1]

      content {
        frequency            = "Daily"
        frequency_in_minutes = each.value.backup.frequency_in_minutes
        time                 = each.value.backup.time 
      }
    }

    dynamic "backup" {
      for_each = lookup(each.value, "retention_daily", null) == "Weekly" ? [] : [1]

      content {
        frequency            = "Weekly"
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

    dynamic "simple_retention" {
      for_each = lookup(each.value, "simple_retention", null) == null ? [] : [1]

      content {
        count = each.value.simple_retention.count
      }
    }
  }
}
