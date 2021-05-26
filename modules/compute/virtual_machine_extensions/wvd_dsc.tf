resource "azurerm_virtual_machine_extension" "session_host_dscextension" {
  for_each                   = var.extension_name == "session_host_dscextension" ? toset(["enabled"]) : toset([])
  name                       = "session_host_dscextension"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true

  settings = jsonencode(
    {
      "modulesURL" : format("%s/DSC/Configuration.zip", var.settings.base_url),
      "configurationFunction" : "Configuration.ps1\\AddSessionHost",
      "properties" : {
        "HostPoolName" : try(var.settings.host_pool_name, var.wvd_host_pools[var.settings.host_pool.host_pool_key].name)
      }
    }
  )
  protected_settings = jsonencode(
    {
      "properties" : {
        "RegistrationInfoToken" : try(var.settings.host_pool_token, data.azurerm_key_vault_secret.host_pool_token["enabled"].value)
      }
    }
  )
}

data "azurerm_key_vault_secret" "host_pool_token" {
  for_each     = var.extension_name == "session_host_dscextension" && try(var.settings.host_pool_token, null) == null ? toset(["enabled"]) : toset([])
  name         = var.settings.host_pool.secret_name
  key_vault_id = try(var.settings.host_pool.key_vault_id, var.keyvaults[var.settings.host_pool.keyvault_key].id)
}