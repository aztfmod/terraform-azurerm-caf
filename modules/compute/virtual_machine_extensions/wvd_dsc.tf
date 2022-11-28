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
      "modulesURL" : format("%s/DSC/Configuration.zip", var.extension.base_url),
      "configurationFunction" : "Configuration.ps1\\AddSessionHost",
      "properties" : {
        "HostPoolName" : coalesce(
          try(var.extension.host_pool_name, ""),
          try(var.wvd_host_pools[var.extension.host_pool.lz_key][var.extension.host_pool.host_pool_key].name, var.wvd_host_pools[var.client_config.landingzone_key][var.extension.host_pool.host_pool_key].name)
        )
      }
    }
  )
  protected_settings = jsonencode(
    {
      "properties" : {
        "RegistrationInfoToken" : try(var.extension.host_pool_token, data.azurerm_key_vault_secret.host_pool_token["enabled"].value)
      }
    }
  )
}

data "azurerm_key_vault_secret" "host_pool_token" {
  for_each = var.extension_name == "session_host_dscextension" && try(var.extension.host_pool_token, null) == null ? toset(["enabled"]) : toset([])
  name     = var.extension.host_pool.secret_name
  key_vault_id = try(
    var.extension.host_pool.key_vault_id,
    try(var.keyvaults[var.extension.host_pool.lz_key][var.extension.host_pool.keyvault_key].id, var.keyvaults[var.client_config.landingzone_key][var.extension.host_pool.keyvault_key].id)
  )
}

