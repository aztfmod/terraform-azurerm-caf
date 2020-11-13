resource "azurerm_mssql_server" "mssql" {

  name                          = azurecaf_name.mssql.result
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = try(var.settings.version, "12.0")
  administrator_login           = var.settings.administrator_login
  administrator_login_password  = try(var.settings.administrator_login_password, azurerm_key_vault_secret.sql_admin_password.0.value)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, true)
  connection_policy             = try(var.settings.connection_policy, null)
  tags                          = local.tags
  dynamic "azuread_administrator" {
    for_each = lookup(var.settings, "azuread_administrator", {}) == {} ? [] : [1]

    content {
      login_username = try(var.settings.azuread_administrator.login_username, try(var.azuread_groups[var.client_config.landingzone_key][var.settings.azuread_administrator.azuread_group_key].name, var.azuread_groups[var.settings.azuread_administrator.lz_key][var.settings.azuread_administrator.azuread_group_key].name))
      object_id      = try(var.settings.azuread_administrator.object_id, try(var.azuread_groups[var.client_config.landingzone_key][var.settings.azuread_administrator.azuread_group_key].id, var.azuread_groups[var.settings.azuread_administrator.lz_key][var.settings.azuread_administrator.azuread_group_key].id))
      tenant_id      = try(var.settings.azuread_administrator.tenant_id, try(var.azuread_groups[var.client_config.landingzone_key][var.settings.azuread_administrator.azuread_group_key].tenant_id, var.azuread_groups[var.settings.azuread_administrator.lz_key][var.settings.azuread_administrator.azuread_group_key].tenant_id))
    }
  }

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) == {} ? [] : [1]

    content {
      type = var.settings.identity.type
    }
  }

}

resource "azurecaf_name" "mssql" {
  name          = var.settings.name
  resource_type = "azurerm_sql_server"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Generate sql server random admin password if not provided in the attribute administrator_login_password
resource "random_password" "sql_admin" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  length           = 128
  special          = true
  upper            = true
  number           = true
  override_special = "$#%"
}

# Store the generated password into keyvault
resource "azurerm_key_vault_secret" "sql_admin_password" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-password", azurecaf_name.mssql.result)
  value        = random_password.sql_admin.0.result
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "azurerm_key_vault_secret" "sql_admin" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-username", azurecaf_name.mssql.result)
  value        = var.settings.administrator_login
  key_vault_id = var.keyvault_id
}


