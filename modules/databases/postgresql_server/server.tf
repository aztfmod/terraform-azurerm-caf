resource "azurerm_postgresql_server" "postgresql" {

  name                          = azurecaf_name.postgresql.result
  location                      = var.location
  resource_group_name           = var.resource_group_name
  administrator_login           = var.settings.administrator_login
  administrator_login_password  = try(var.settings.administrator_login_password, azurerm_key_vault_secret.sql_admin_password.0.value)
 

  sku_name                      = var.settings.sku_name
  version                       = var.settings.version
  storage_mb                    = try(var.settings.storage_mb, null)
  
  auto_grow_enabled             = try(var.settings.auto_grow_enabled, false)
  backup_retention_days         = try(var.settings.backup_retention_days, null)
  create_mode                   = try(var.settings.create_mode, "Default")
  infrastructure_encryption_enabled = try(var.settings.infrastructure_encryption_enableduto_grow_enabled, false)
 
  public_network_access_enabled = try(var.settings.public_network_access_enabled, true)
  tags                          = try(var.settings.tags, null)
  ssl_enforcement_enabled       = try(var.settings.ssl_enforcement_enabled, true)
  ssl_minimal_tls_version_enforced       = try(var.settings.ssl_minimal_tls_version_enforced, "TLSEnforcementDisabled")
  restore_point_in_time       = try(var.settings.restore_point_in_time, null)
  

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) == {} ? [] : [1]

    content {
      type = var.settings.identity.type
    }
  }

}

resource "azurecaf_name" "postgresql" {
  name          = var.settings.name
  resource_type = "azurerm_postgresql_server"
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

  name         = format("%s-password", azurecaf_name.postgresql.result)
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

  name         = format("%s-username", azurecaf_name.postgresql.result)
  value        = var.settings.administrator_login
  key_vault_id = var.keyvault_id
}

/*resource "azurerm_key_vault_secret" "sql_fqdn" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-fqdn", azurecaf_name.postgresql.result)
  value        = azurerm_postgresql_server.postgresql.fully_qualified_domain_name
  key_vault_id = var.keyvault_id
}*/


