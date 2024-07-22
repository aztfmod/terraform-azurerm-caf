resource "azurecaf_name" "postgresql_flexible_server" {
  name          = var.settings.name
  resource_type = "azurerm_postgresql_flexible_server"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_postgresql_flexible_server" "postgresql" {
  name                = azurecaf_name.postgresql_flexible_server.result
  resource_group_name = local.resource_group_name
  location            = local.location
  version             = try(var.settings.version, null)
  sku_name            = try(var.settings.sku_name, null)
  zone                = try(var.settings.zone, null)
  storage_mb          = try(var.settings.storage_mb, null)

  delegated_subnet_id = var.remote_objects.subnet_id
  private_dns_zone_id = var.remote_objects.private_dns_zone_id

  create_mode                       = try(var.settings.create_mode, "Default")
  point_in_time_restore_time_in_utc = try(var.settings.create_mode, "PointInTimeRestore") == "PointInTimeRestore" ? try(var.settings.point_in_time_restore_time_in_utc, null) : null
  source_server_id                  = try(var.settings.create_mode, "PointInTimeRestore") == "PointInTimeRestore" ? try(var.settings.source_server_id, null) : null

  administrator_login    = try(var.settings.create_mode, "Default") == "Default" && try(var.settings.authentication.password_auth_enabled, true) ? try(var.settings.administrator_username, "pgadmin") : null
  administrator_password = try(var.settings.create_mode, "Default") == "Default" && try(var.settings.authentication.password_auth_enabled, true) ? try(var.settings.administrator_password, azurerm_key_vault_secret.postgresql_administrator_password.0.value) : null

  dynamic "authentication" {
    for_each = try(var.settings.authentication, null) == null ? [] : [var.settings.authentication]
    content {
      active_directory_auth_enabled = try(var.settings.authentication.active_directory_auth_enabled, null)
      password_auth_enabled         = try(var.settings.authentication.password_auth_enabled, null)
      tenant_id                     = can(var.settings.authentication.tenant_id) ? var.settings.authentication.tenant_id : var.client_config.tenant_id
    }
  }

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
resource "azurerm_key_vault_secret" "postgresql_administrator_username" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-username", azurecaf_name.postgresql_flexible_server.result)
  value        = try(var.settings.administrator_username, "pgadmin")
  key_vault_id = var.remote_objects.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

# Generate random postgresql_flexible_administrator_password if attribute administrator_password not provided.
resource "random_password" "postgresql_administrator_password" {
  count = lookup(var.settings, "administrator_password", null) == null ? 1 : 0

  length           = try(var.settings.administrator_password_length, 128)
  upper            = true
  numeric          = true
  special          = true
  override_special = "$#%"
}

# Store the postgresql_flexible_administrator_password into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "postgresql_administrator_password" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-password", azurecaf_name.postgresql_flexible_server.result)
  value        = try(var.settings.administrator_password, random_password.postgresql_administrator_password.0.result)
  key_vault_id = var.remote_objects.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

# Store the postgresql_flexible_fqdn into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "postgresql_fqdn" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-fqdn", azurecaf_name.postgresql_flexible_server.result)
  value        = azurerm_postgresql_flexible_server.postgresql.fqdn
  key_vault_id = var.remote_objects.keyvault_id
}

resource "azurerm_postgresql_flexible_server_active_directory_administrator" "administrator" {
  for_each            = try(var.settings.authentication.active_directory_administrators, {})
  server_name         = azurerm_postgresql_flexible_server.postgresql.name
  resource_group_name = local.resource_group_name
  tenant_id           = try(var.settings.authentication.tenant_id, var.client_config.tenant_id)
  object_id = can(each.value.object_id) ? each.value.object_id : (
    each.value.principal_type == "ServicePrincipal" ? var.remote_objects.service_principals[try(each.value.object_lz_key, var.client_config.landingzone_key)][each.value.object_key].object_id :
    each.value.principal_type == "Group" ? var.remote_objects.azuread_groups[try(each.value.object_lz_key, var.client_config.landingzone_key)][each.value.object_key].object_id :
    each.value.principal_type == "User" ? var.remote_objects.azuread_users[try(each.value.object_lz_key, var.client_config.landingzone_key)][each.value.object_key].object_id :
    each.value.principal_type == "ManagedIdentity" ? var.remote_objects.managed_identities[try(each.value.object_lz_key, var.client_config.landingzone_key)][each.value.object_key].principal_id : null
  )
  principal_name = each.value.principal_name
  principal_type = each.value.principal_type == "ManagedIdentity" ? "ServicePrincipal" : each.value.principal_type
}
