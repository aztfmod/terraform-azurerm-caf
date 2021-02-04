data "azurerm_storage_account_sas" "backup" {
  count            = try(var.settings.backup, null) != null ? 1 : 0

  connection_string = local.backup_storage_account.primary_connection_string

  resource_types {
    service   = true
    container = false
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = formatdate("YYYY-MM-DD", timestamp())
  expiry = formatdate("YYYY-MM-DD", timeadd(timestamp(), "8760h")) //1 year

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