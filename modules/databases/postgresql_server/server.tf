

resource "azurerm_postgresql_server" "server" {
  name                          = var.settings.name
  resource_group_name           = var.resource_group_name
  location                      = var.location

  administrator_login          = var.settings.administrator_login
  administrator_login_password = var.settings.administrator_login_password

  sku_name   = var.settings.sku_name
  version    = var.settings.version
  storage_mb = var.settings.storage_mb

  backup_retention_days        = var.settings.backup_retention_days
  geo_redundant_backup_enabled = var.settings.geo_redundant_backup_enabled
  auto_grow_enabled            = var.settings.auto_grow_enabled

  public_network_access_enabled    = var.settings.public_network_access_enabled
  ssl_enforcement_enabled          = var.settings.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.settings.ssl_minimal_tls_version_enforced
}