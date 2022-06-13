resource "azurerm_mariadb_server" "mariadb" {
  name                = azurecaf_name.mariadb.result
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.settings.administrator_login
  administrator_login_password = try(var.settings.administrator_login_password, azurerm_key_vault_secret.mariadb_admin_password.0.value)

  sku_name   = var.settings.sku_name
  storage_mb = var.settings.storage_mb
  version    = var.settings.version

  auto_grow_enabled             = try(var.settings.auto_grow_enabled, true)
  backup_retention_days         = try(var.settings.backup_retention_days, null)
  geo_redundant_backup_enabled  = try(var.settings.geo_redundant_backup_enabled, null)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, false)
  ssl_enforcement_enabled       = try(var.settings.ssl_enforcement_enabled, true)
  create_mode                   = try(var.settings.create_mode, "Default")
  creation_source_server_id     = try(var.settings.creation_source_server_id, null)
  tags                          = local.tags
}

# Generate mariadb server random admin password if not provided in the attribute administrator_login_password
resource "random_password" "mariadb_admin" {
  count            = try(var.settings.administrator_login_password, null) == null ? 1 : 0
  length           = 32
  special          = true
  upper            = true
  numeric          = true
  override_special = "_%@"

}

# Store the generated password into keyvault
resource "azurerm_key_vault_secret" "mariadb_admin_password" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-password", azurecaf_name.mariadb.result)
  value        = random_password.mariadb_admin.0.result
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "azurerm_key_vault_secret" "mariadb_admin" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-username", azurecaf_name.mariadb.result)
  value        = var.settings.administrator_login
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "mariadb_admin_login_name" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-login-name", azurecaf_name.mariadb.result)
  value        = format("%s@%s", var.settings.administrator_login, azurerm_mariadb_server.mariadb.fqdn)
  key_vault_id = var.keyvault_id
}

resource "azurerm_key_vault_secret" "mariadb_fqdn" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-fqdn", azurecaf_name.mariadb.result)
  value        = azurerm_mariadb_server.mariadb.fqdn
  key_vault_id = var.keyvault_id
}

resource "azurecaf_name" "mariadb" {
  name          = var.settings.name
  resource_type = "azurerm_mariadb_server"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}




