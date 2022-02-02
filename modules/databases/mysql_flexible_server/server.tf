resource "azurerm_mysql_flexible_server" "mysql" {
  name                = var.settings.name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  version             = try(var.settings.version, null)
  sku_name            = try(var.settings.sku_name, null)
  zone                = try(var.settings.zone, null)
  

  delegated_subnet_id = var.remote_objects.subnet_id
  private_dns_zone_id = var.remote_objects.private_dns_zone_id

  create_mode                       = try(var.settings.create_mode, "Default")
  point_in_time_restore_time_in_utc = try(var.settings.create_mode, "PointInTimeRestore") == "PointInTimeRestore" ? try(var.settings.point_in_time_restore_time_in_utc, null) : null
  source_server_id                  = try(var.settings.create_mode, "PointInTimeRestore") == "PointInTimeRestore" ? try(var.settings.source_server_id, null) : null

  administrator_login    = try(var.settings.create_mode, "Default") == "Default" ? try(var.settings.administrator_username, "psqladmin") : null
  administrator_password = try(var.settings.create_mode, "Default") == "Default" ? try(var.settings.administrator_password) : null

  backup_retention_days = try(var.settings.backup_retention_days, null)

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

  lifecycle {
    ignore_changes = [
      private_dns_zone_id,
      tags
    ]
  }

  tags = merge(local.tags, lookup(var.settings, "tags", {}))
}

# Store the postgresql_flexible_server administrator_username into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "mysql_administrator_username" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-username", azurerm_mysql_flexible_server.mysql.name)
  value        = try(var.settings.administrator_username, "psqladmin")
  key_vault_id = var.remote_objects.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

# Generate random postgresql_flexible_administrator_password if attribute administrator_password not provided.
resource "random_password" "mysql_administrator_password" {
  count = lookup(var.settings, "administrator_password", null) == null ? 1 : 0

  length           = try(var.settings.administrator_password_length, 128)
  upper            = true
  number           = true
  special          = true
  override_special = "$#%"
}

# Store the postgresql_flexible_administrator_password into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "mysql_administrator_password" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-password", azurerm_mysql_flexible_server.mysql.name)
  value        = try(var.settings.administrator_password, random_password.mysql_administrator_password.0.result)
  key_vault_id = var.remote_objects.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

# Store the postgresql_flexible_fqdn into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "mysql_fqdn" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-fqdn", azurerm_mysql_flexible_server.mysql.name)
  value        = azurerm_mysql_flexible_server.mysql.fqdn
  key_vault_id = var.remote_objects.keyvault_id
}

