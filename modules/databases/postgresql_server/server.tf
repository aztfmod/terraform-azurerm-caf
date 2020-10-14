

resource "azurerm_postgresql_server" "example" {
  name                = each.value.name
  resource_group_name           = var.resource_group_name
  location                      = var.location

  administrator_login          = each.value.settings.administrator_login
  administrator_login_password = each.value.settings.administrator_login_password

  sku_name   = each.value.settings.sku_name
  version    = each.value.settings.version
  storage_mb = each.value.settings.storage_mb

  backup_retention_days        = each.value.settings.backup_retention_days
  geo_redundant_backup_enabled = each.value.settings.geo_redundant_backup_enabled
  auto_grow_enabled            = each.value.settings.auto_grow_enabled

  public_network_access_enabled    = each.value.settings.public_network_access_enabled
  ssl_enforcement_enabled          = each.value.settings.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = each.value.settings.ssl_minimal_tls_version_enforced
}