resource "azurerm_virtual_machine_extension" "domainjoin" {
  for_each                   = var.extension_name == "microsoft_azure_domainJoin" ? toset(["enabled"]) : toset([])
  name                       = "microsoft_azure_domainJoin"
  virtual_machine_id         = var.virtual_machine_id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = try(var.extension.type_handler_version, "1.3")
  auto_upgrade_minor_version = try(var.extension.auto_upgrade_minor_version, true)

  lifecycle {
    ignore_changes = [
      settings,
      protected_settings
    ]
  }

  settings = jsonencode(
    {
      "Name" : var.extension.domain_name,
      "OUPath" : try(var.extension.ou_path, ""),
      "User" : data.azurerm_key_vault_secret.domain_join_username["enabled"].value,
      "Restart" : try(var.extension.restart, "false"),
      "Options" : try(var.extension.options, "3")
    }
  )

  protected_settings = jsonencode(
    {
      "Password" : data.azurerm_key_vault_secret.domain_join_password["enabled"].value
    }
  )
}

data "azurerm_key_vault_secret" "domain_join_password" {
  for_each = var.extension_name == "microsoft_azure_domainJoin" ? toset(["enabled"]) : toset([])
  name     = var.extension.domain_join_password_keyvault.secret_name
  key_vault_id = try(
    var.extension.domain_join_password_keyvault.key_vault_id,
    try(var.keyvaults[var.extension.domain_join_password_keyvault.lz_key][var.extension.domain_join_password_keyvault.keyvault_key].id, var.keyvaults[var.client_config.landingzone_key][var.extension.domain_join_password_keyvault.keyvault_key].id)
  )
}

data "azurerm_key_vault_secret" "domain_join_username" {
  for_each = var.extension_name == "microsoft_azure_domainJoin" ? toset(["enabled"]) : toset([])
  name     = var.extension.domain_join_username_keyvault.secret_name
  key_vault_id = try(
    var.extension.domain_join_username_keyvault.key_vault_id,
    try(var.keyvaults[var.extension.domain_join_username_keyvault.lz_key][var.extension.domain_join_username_keyvault.keyvault_key].id, var.keyvaults[var.client_config.landingzone_key][var.extension.domain_join_username_keyvault.keyvault_key].id)
  )
}

