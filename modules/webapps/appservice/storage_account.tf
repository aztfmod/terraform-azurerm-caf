data "azurerm_storage_account_sas" "backup" {
  count            = try(var.settings.backup, null) != null ? 1 : 0

  connection_string = local.backup_storage_account.primary_connection_string
  https_only        = true
  signed_version    = "2019-12-12"

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = time_rotating.sas[0].id
  expiry = timeadd(time_rotating.sas[0].id, format("%sh", var.settings.backup.sas_policy.expire_in_days * 24))

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
  }
}

resource "time_rotating" "sas" {
  count            = try(var.settings.backup, null) != null ? 1 : 0

  rotation_minutes = lookup(var.settings.backup.sas_policy.rotation, "mins", null)
  rotation_days    = lookup(var.settings.backup.sas_policy.rotation, "days", null)
  rotation_months  = lookup(var.settings.backup.sas_policy.rotation, "months", null)
  rotation_years   = lookup(var.settings.backup.sas_policy.rotation, "years", null)
}