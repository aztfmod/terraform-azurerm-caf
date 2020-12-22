
resource "azurerm_backup_policy_vm" "vm" {
  depends_on = [azurerm_recovery_services_vault.asr]
  for_each   = try(var.settings.backup_policies.vms, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurecaf_name.asr_rg_vault.result

  timezone = try(each.value.timezone, null)

  dynamic "backup" {
    for_each = lookup(each.value, "backup", null) == null ? [] : [1]

    content {
      frequency = lookup(each.value.backup, "frequency", null)
      time      = each.value.backup.time
      weekdays  = lookup(each.value.backup, "weekdays", null)
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
      count    = each.value.retention_monthly.count
      weekdays = each.value.retention_monthly.weekdays
      weeks    = each.value.retention_monthly.weeks
    }
  }

  dynamic "retention_yearly" {
    for_each = lookup(each.value, "retention_yearly", null) == null ? [] : [1]

    content {
      count    = each.value.retention_yearly.count
      weekdays = each.value.retention_yearly.weekdays
      weeks    = each.value.retention_yearly.weeks
      months   = each.value.retention_yearly.months
    }
  }
}
