

# moved {
#   from = mssql_managed_database_v2.sqlmanageddatabase
#   to   = mssql_managed_database_restore_v1.sqlmanageddatabase
# }

resource "azurecaf_name" "manageddb" {

  name          = var.settings.name
  resource_type = "azurerm_mssql_database"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough

}

# managed database using azapi (since Azurerm provider does not have create from backup capability)
resource "azapi_resource" "sqlmanageddatabase" {

  type      = "Microsoft.Sql/managedInstances/databases@2021-11-01"
  name      = azurecaf_name.manageddb.result
  location  = var.server_location
  parent_id = var.server_id
  tags      = merge(local.tags, try(var.settings.tags, null))
  body = jsonencode({
    properties = {
      autoCompleteRestore               = try(var.settings.properties.auto_complete_restore, null)
      catalogCollation                  = try(var.settings.properties.catalog_collation, null)
      collation                         = try(var.settings.properties.collation, "SQL_Latin1_General_CP1_CI_AS")
      createMode                        = local.create_mode
      lastBackupName                    = try(var.settings.properties.last_backup_name, null)
      longTermRetentionBackupResourceId = try(local.long_term_retention_backup_id, null)
      recoverableDatabaseId             = try(local.recoverable_database_id, null)
      restorableDroppedDatabaseId       = try(local.restorable_dropped_database_id, null)
      restorePointInTime                = try(local.restore_point_datetime, null)
      sourceDatabaseId                  = try(local.source_database_id, null)
      storageContainerSasToken          = try(var.settings.properties.storage_container_sas_token, null)
      storageContainerUri               = try(var.settings.properties.storage_container_uri, null)
    }
  })
}

#create short term retention from the configuration
resource "azapi_update_resource" "short_term_retention" {
  depends_on = [
    azapi_resource.sqlmanageddatabase
  ]
  type      = "Microsoft.Sql/managedInstances/databases/backupShortTermRetentionPolicies@2021-11-01"
  name      = "default"
  parent_id = resource.azapi_resource.sqlmanageddatabase.id
  body = jsonencode({
    properties = {
      retentionDays = local.short_term_retention_days
    }
  })
}

#set longterm retention settings
resource "azapi_update_resource" "longtermretention" {
  depends_on = [
    azapi_resource.sqlmanageddatabase
  ]
  count     = can(var.settings.long_term_retention_policy) ? 1 : 0
  type      = "Microsoft.Sql/managedInstances/databases/backupLongTermRetentionPolicies@2021-11-01"
  name      = "default"
  parent_id = resource.azapi_resource.sqlmanageddatabase.id
  body = jsonencode({
    properties = {
      weeklyRetention  = local.long_term_retention_policy.weekly_retention
      monthlyRetention = local.long_term_retention_policy.monthly_retention
      yearlyRetention  = local.long_term_retention_policy.yearly_retention
      weekOfYear       = local.long_term_retention_policy.week_of_year

    }
  })
}

#validation module for settings
module "var_settings" {

  source = "./var/settings"

  create_mode               = try(var.settings.properties.create_mode, null)
  short_term_retention_days = try(var.settings.short_term_retention_days, null)
}

locals {
  create_mode                    = try(module.var_settings.create_mode, null)
  short_term_retention_days      = module.var_settings.short_term_retention_days
  source_database_id             = try(var.settings.properties.is_source_database_deleted, null) != true ? try(var.source_database_id, null) : null
  restore_point_datetime         = try(var.settings.properties.restore_point_datetime, null)
  long_term_retention_backup_id  = try(var.settings.properties.long_term_retention_backup_id, null)
  recoverable_database_id        = try(var.settings.properties.recoverable_database_id, null)
  restorable_dropped_database_id = try(var.settings.properties.is_source_database_deleted, null) == true ? try(var.settings.properties.source_database.id, null) : null
  long_term_retention_policy = {
    weekly_retention  = try(var.settings.long_term_retention_policy.weekly_retention, null)
    monthly_retention = try(var.settings.long_term_retention_policy.monthly_retention, null)
    yearly_retention  = try(var.settings.long_term_retention_policy.yearly_retention, null)
    week_of_year      = try(var.settings.long_term_retention_policy.week_of_year, null)

  }


}


