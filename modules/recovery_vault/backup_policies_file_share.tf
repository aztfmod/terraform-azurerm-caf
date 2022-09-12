# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_policy_file_share

resource "azurerm_backup_policy_file_share" "fs" {
  for_each = try(var.settings.backup_policies.fs, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.asr.name

  timezone = try(each.value.timezone, null)

  dynamic "backup" {
    for_each = lookup(each.value, "backup", null) == null ? [] : [1]

    content {
      frequency = each.value.backup.frequency
      time      = each.value.backup.time
    }
  }

  dynamic "retention_daily" {
    for_each = each.value.retention_daily

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

# TODO: SAP HANA in Azure VM when available
# TODO: SQL Server in Azure VM when available
