resource "azurecaf_name" "mssqldb" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_database"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_mssql_database" "mssqldb" {
  auto_pause_delay_in_minutes = try(var.settings.auto_pause_delay_in_minutes, null)
  collation                   = try(var.settings.collation, null)
  create_mode                 = try(var.settings.create_mode, null)
  creation_source_database_id = try(var.settings.creation_source_database_id, null)
  elastic_pool_id             = try(var.elastic_pool_id, null)
  geo_backup_enabled          = try(var.settings.geo_backup_enabled, false)
  license_type                = try(var.settings.license_type, null)
  max_size_gb                 = try(var.settings.max_size_gb, null)
  min_capacity                = try(var.settings.min_capacity, null)
  name                        = azurecaf_name.mssqldb.result
  read_replica_count          = try(var.settings.read_replica_count, null)
  read_scale                  = try(var.settings.read_scale, null)
  recover_database_id         = try(var.settings.recover_database_id, null)
  restore_dropped_database_id = try(var.settings.restore_dropped_database_id, null)
  restore_point_in_time       = try(var.settings.restore_point_in_time, null)
  sample_name                 = try(var.settings.sample_name, null)
  server_id                   = var.server_id
  sku_name                    = try(var.settings.sku_name, null)
  storage_account_type        = try(var.settings.storage_account_type, null)
  tags                        = local.tags
  zone_redundant              = try(var.settings.zone_redundant, null)

  dynamic "threat_detection_policy" {
    for_each = lookup(var.settings, "threat_detection_policy", {}) == {} ? [] : [1]

    content {
      state                      = var.settings.threat_detection_policy.state
      disabled_alerts            = try(var.settings.threat_detection_policy.disabled_alerts, null)
      email_account_admins       = try(var.settings.threat_detection_policy.email_account_admins, null)
      email_addresses            = try(var.settings.threat_detection_policy.email_addresses, null)
      retention_days             = try(var.settings.threat_detection_policy.retention_days, null)
      storage_endpoint           = try(data.azurerm_storage_account.mssqldb_tdp.0.primary_blob_endpoint, null)
      storage_account_access_key = try(data.azurerm_storage_account.mssqldb_tdp.0.primary_access_key, null)
      use_server_default         = try(var.settings.threat_detection_policy.use_server_default, null)
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = lookup(var.settings, "short_term_retention_policy", {}) == {} ? [] : [1]
    content {
      retention_days = try(var.settings.short_term_retention_policy.retention_days, null)
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = lookup(var.settings, "long_term_retention_policy", {}) == {} ? [] : [1]
    content {
      weekly_retention  = try(var.settings.long_term_retention_policy.weekly_retention, null)
      monthly_retention = try(var.settings.long_term_retention_policy.monthly_retention, null)
      yearly_retention  = try(var.settings.long_term_retention_policy.yearly_retention, null)
      week_of_year      = try(var.settings.long_term_retention_policy.week_of_year, null)
    }
  }


}



# threat detection policy

data "azurerm_storage_account" "mssqldb_tdp" {
  count = try(var.settings.threat_detection_policy.storage_account.key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.threat_detection_policy.storage_account.key].name
  resource_group_name = var.storage_accounts[var.settings.threat_detection_policy.storage_account.key].resource_group_name
}