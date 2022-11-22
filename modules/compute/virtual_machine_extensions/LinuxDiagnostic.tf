resource "azurerm_virtual_machine_extension" "linux_diagnostic" {
  for_each = var.extension_name == "linux_diagnostic" ? toset(["enabled"]) : toset([])

  name                       = "linux_diagnostic"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Azure.Diagnostics"
  type                       = "LinuxDiagnostic"
  type_handler_version       = try(var.extension.type_handler_version, "4.0")
  automatic_upgrade_enabled  = try(var.extension.auto_upgrade_minor_version, false)
  auto_upgrade_minor_version = try(var.extension.auto_upgrade_minor_version, true)

  settings = jsonencode({
    "ladCfg"         = jsondecode(templatefile(local.linux_diagnostic.ladcfg, { virtual_machine_id = var.virtual_machine_id }))
    "fileLogs"       = try(jsondecode(file(local.linux_diagnostic.file_logs)), null)
    "StorageAccount" = var.settings.diagnostic_storage_account.name
  })
  protected_settings = jsonencode({
    "storageAccountName"     = var.settings.diagnostic_storage_account.name
    "storageAccountSasToken" = data.azurerm_storage_account_sas.token[each.key].sas
    "storageAccountEndPoint" = try(var.settings.storage_account_endpoint, "https://core.windows.net")
  })
}

locals {
  linux_diagnostic = {
    ladcfg    = var.extension_name == "linux_diagnostic" && can(var.extension.ladcfg_file_path) ? fileexists(var.extension.ladcfg_file_path) ? var.extension.ladcfg_file_path : format("%s/%s", var.settings.var_folder_path, var.extension.ladcfg_file_path) : null
    file_logs = var.extension_name == "linux_diagnostic" && can(var.extension.filelogs_file_path) ? fileexists(var.extension.filelogs_file_path) ? var.extension.filelogs_file_path : format("%s/%s", var.settings.var_folder_path, var.extension.filelogs_file_path) : null
  }
}

data "azurerm_storage_account_sas" "token" {
  for_each = var.extension_name == "linux_diagnostic" ? toset(["enabled"]) : toset([])

  connection_string = var.settings.diagnostic_storage_account.primary_connection_string
  https_only        = true

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    table = true
    queue = false
    file  = false
  }

  start  = "2018-03-21T00:00:00Z"
  expiry = "2037-12-31T23:59:00Z"

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = true
    process = true
  }
}