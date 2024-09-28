
resource "azurecaf_name" "mysql_flexible_server" {
  name          = var.settings.name
  resource_type = "azurerm_mysql_flexible_server"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_mysql_flexible_server" "mysql" {
  name                = azurecaf_name.mysql_flexible_server.result
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = try(var.settings.version, null)
  sku_name            = try(var.settings.sku_name, null)
  zone                = try(var.settings.zone, null)

  delegated_subnet_id = var.remote_objects.subnet_id
  private_dns_zone_id = var.remote_objects.private_dns_zone_id

  create_mode                       = try(var.settings.create_mode, "Default")
  point_in_time_restore_time_in_utc = try(var.settings.create_mode, "PointInTimeRestore") == "PointInTimeRestore" ? try(var.settings.point_in_time_restore_time_in_utc, null) : null
  source_server_id                  = try(var.settings.create_mode, "PointInTimeRestore") == "PointInTimeRestore" ? try(var.settings.source_server_id, null) : null

  administrator_login          = try(var.settings.create_mode, "Default") == "Default" ? try(var.settings.administrator_username, "psqladmin") : null
  administrator_password       = try(var.settings.create_mode, "Default") == "Default" ? try(var.settings.administrator_password, azurerm_key_vault_secret.mysql_administrator_password.0.value) : null
  geo_redundant_backup_enabled = try(var.settings.geo_redundant_backup_enabled, false)
  backup_retention_days        = try(var.settings.backup_retention_days, null)

  dynamic "maintenance_window" {
    for_each = try(var.settings.maintenance_window, null) == null ? [] : [var.settings.maintenance_window]

    content {
      day_of_week  = try(var.settings.maintenance_window.day_of_week, 0)
      start_hour   = try(var.settings.maintenance_window.start_hour, 0)
      start_minute = try(var.settings.maintenance_window.start_minute, 0)
    }
  }

  dynamic "high_availability" {
    for_each = try(var.settings.high_availability, null) == null ? [] : [var.settings.high_availability]

    content {
      mode                      = "ZoneRedundant"
      standby_availability_zone = var.settings.zone == null ? null : var.settings.high_availability.standby_availability_zone
    }
  }

  dynamic "storage" {
    for_each = try(var.settings.storage, null) == null ? [] : [var.settings.storage]

    content {
      auto_grow_enabled  = try(var.settings.storage.auto_grow_enabled, "True")
      io_scaling_enabled = try(var.settings.storage.io_scaling_enabled, "False")
      iops               = var.settings.storage.io_scaling_enabled ? null : try(var.settings.storage.iops, "360")
      size_gb            = var.settings.storage.io_scaling_enabled ? null : try(var.settings.storage.size_gb, "20")
    }
  }

  lifecycle {
    ignore_changes = [
      private_dns_zone_id,
      tags
    ]
  }

  tags = merge(local.tags, lookup(var.settings, "tags", {}))
}

# Store the mysql_flexible_server administrator_username into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "mysql_administrator_username" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-mysql-administrator-username", azurecaf_name.mysql_flexible_server.result)
  value        = try(var.settings.administrator_username, "psqladmin")
  key_vault_id = var.remote_objects.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

# Generate random mysql_flexible_administrator_password if attribute administrator_password not provided.
resource "random_password" "mysql_administrator_password" {
  count = lookup(var.settings, "administrator_password", null) == null ? 1 : 0

  length           = try(var.settings.administrator_password_length, 32)
  upper            = true
  numeric          = true
  special          = true
  override_special = "!@"
}

# Store the mysql_flexible_administrator_password into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "mysql_administrator_password" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-mysql-administrator-password", azurecaf_name.mysql_flexible_server.result)
  value        = try(var.settings.administrator_password, random_password.mysql_administrator_password.0.result)
  key_vault_id = var.remote_objects.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

# Store the mysql_flexible_fqdn into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "mysql_fqdn" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-mysql-fqdn", azurecaf_name.mysql_flexible_server.result)
  value        = azurerm_mysql_flexible_server.mysql.fqdn
  key_vault_id = var.remote_objects.keyvault_id
}
