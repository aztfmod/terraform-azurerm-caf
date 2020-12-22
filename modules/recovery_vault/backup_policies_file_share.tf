resource "azurerm_backup_policy_file_share" "fs" {
  depends_on = [azurerm_recovery_services_vault.asr]
  for_each   = try(var.settings.backup_policies.fs, {})

  name                = each.value.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurecaf_name.asr_rg_vault.result

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
}

# TODO: SAP HANA in Azure VM when available
# TODO: SQL Server in Azure VM when available
