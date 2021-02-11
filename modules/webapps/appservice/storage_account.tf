data "azurerm_storage_account_blob_container_sas" "backup" {
  count            = try(var.settings.backup, null) != null ? 1 : 0

  connection_string = local.backup_storage_account.primary_connection_string
  container_name    = local.backup_storage_account.containers[var.settings.backup.container_key].name
  https_only        = true

  #ip_address = "168.1.5.65"

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

  # cache_control       = "max-age=5"
  # content_disposition = "inline"
  # content_encoding    = "deflate"
  # content_language    = "en-US"
  # content_type        = "application/json"
}

resource "time_rotating" "sas" {
  count            = try(var.settings.backup, null) != null ? 1 : 0

  rotation_minutes = lookup(var.settings.backup.sas_policy.rotation, "mins", null)
  rotation_days    = lookup(var.settings.backup.sas_policy.rotation, "days", null)
  rotation_months  = lookup(var.settings.backup.sas_policy.rotation, "months", null)
  rotation_years   = lookup(var.settings.backup.sas_policy.rotation, "years", null)
}