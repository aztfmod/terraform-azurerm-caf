resource "azurerm_mysql_server" "mysql" {

  name                          = azurecaf_name.mysql.result
  sku_name                      = var.settings.sku_name
  storage_mb                    = var.settings.storage_mb
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = try(var.settings.version, "5.7")
  administrator_login           = var.settings.administrator_login
  administrator_login_password  = try(var.settings.administrator_login_password, azurerm_key_vault_secret.sql_admin_password.0.value)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, true)
  #connection_policy             = try(var.settings.connection_policy, null)
  tags                          = try(var.settings.tags, null)
  ssl_enforcement_enabled       = try(var.settings.ssl_enforcement_enabled, true)

  /*dynamic "azuread_administrator" {
    for_each = lookup(var.settings, "azuread_administrator", {}) == {} ? [] : [1]

    content {
      login_username = try(var.settings.azuread_administrator.login_username, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].name)
      object_id      = try(var.settings.azuread_administrator.object_id, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].id)
      tenant_id      = try(var.settings.azuread_administrator.tenant_id, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].tenant_id)
    }
  }*/

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) == {} ? [] : [1]

    content {
      type = var.settings.identity.type
    }
  }

}

resource "azurecaf_name" "mysql" {
  name          = var.settings.name
  resource_type = "azurerm_sql_server"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
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

  name         = format("%s-password", azurecaf_name.mysql.result)
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

  name         = format("%s-username", azurecaf_name.mysql.result)
  value        = var.settings.administrator_login
  key_vault_id = var.keyvault_id
}



