data "azurerm_storage_account" "backup_storage_account" {
  count = can(var.settings.backup) ? 1 : 0

  name                = local.backup_storage_account.name
  resource_group_name = local.backup_storage_account.resource_group_name
}

data "azurerm_storage_account_blob_container_sas" "backup" {
  count = can(var.settings.backup) ? 1 : 0

  connection_string = data.azurerm_storage_account.backup_storage_account.0.primary_connection_string
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

data "azurerm_storage_account_blob_container_sas" "logs" {
  count = can(var.settings.logs) ? 1 : 0

  connection_string = data.azurerm_storage_account.backup_storage_account.0.primary_connection_string
  container_name    = local.logs_storage_account.containers[var.settings.logs.container_key].name
  https_only        = true

  start  = time_rotating.logs_sas[0].id
  expiry = timeadd(time_rotating.logs_sas[0].id, format("%sh", var.settings.logs.sas_policy.expire_in_days * 24))

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = true
    list   = true
  }
}


data "azurerm_storage_account_blob_container_sas" "http_logs" {
  count = can(var.settings.logs.http_logs) ? 1 : 0

  connection_string = data.azurerm_storage_account.backup_storage_account.0.primary_connection_string
  container_name    = local.http_logs_storage_account.containers[var.settings.logs.http_logs.container_key].name
  https_only        = true

  start  = time_rotating.http_logs_sas[0].id
  expiry = timeadd(time_rotating.http_logs_sas[0].id, format("%sh", var.settings.logs.http_logs.sas_policy.expire_in_days * 24))

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
  count = can(var.settings.backup.sas_policy) ? 1 : 0

  rotation_minutes = lookup(var.settings.backup.sas_policy.rotation, "mins", null)
  rotation_days    = lookup(var.settings.backup.sas_policy.rotation, "days", null)
  rotation_months  = lookup(var.settings.backup.sas_policy.rotation, "months", null)
  rotation_years   = lookup(var.settings.backup.sas_policy.rotation, "years", null)
}

resource "time_rotating" "logs_sas" {
  count = can(var.settings.logs.sas_policy) ? 1 : 0

  rotation_minutes = lookup(var.settings.logs.sas_policy.rotation, "mins", null)
  rotation_days    = lookup(var.settings.logs.sas_policy.rotation, "days", null)
  rotation_months  = lookup(var.settings.logs.sas_policy.rotation, "months", null)
  rotation_years   = lookup(var.settings.logs.sas_policy.rotation, "years", null)
}

resource "time_rotating" "http_logs_sas" {
  count = can(var.settings.logs.http_logs.sas_policy) ? 1 : 0

  rotation_minutes = lookup(var.settings.logs.http_logs.sas_policy.rotation, "mins", null)
  rotation_days    = lookup(var.settings.logs.http_logs.sas_policy.rotation, "days", null)
  rotation_months  = lookup(var.settings.logs.http_logs.sas_policy.rotation, "months", null)
  rotation_years   = lookup(var.settings.logs.http_logs.sas_policy.rotation, "years", null)
}
