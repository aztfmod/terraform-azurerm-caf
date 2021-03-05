data "azurerm_storage_account_blob_container_sas" "backup" {
  count            = try(var.settings.backup, null) != null ? 1 : 0

  connection_string = local.backup_storage_account.primary_connection_string
  container_name    = local.backup_storage_account.containers[var.settings.backup.container_key].name
  https_only        = true

  start  = time_rotating.sas[0].id
  expiry = timeadd(time_rotating.sas[0].id, format("%sh", var.settings.backup.sas_policy.expire_in_days * 24))

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }
}

resource "time_rotating" "sas" {
  count            = try(var.settings.backup, null) != null ? 1 : 0

  rotation_minutes = lookup(var.settings.backup.sas_policy.rotation, "mins", null)
  rotation_days    = lookup(var.settings.backup.sas_policy.rotation, "days", null)
  rotation_months  = lookup(var.settings.backup.sas_policy.rotation, "months", null)
  rotation_years   = lookup(var.settings.backup.sas_policy.rotation, "years", null)
}