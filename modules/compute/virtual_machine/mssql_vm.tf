resource "azurerm_mssql_virtual_machine" "mssqlvm" {
  for_each = {
    for key, value in try(var.settings.virtual_machine_settings, {}) : key => value
    if try(value.mssql_settings, null) != null
  }

  virtual_machine_id               = local.os_type == "windows" ? try(azurerm_windows_virtual_machine.vm[each.key].id, null) : try(azurerm_linux_virtual_machine.vm[each.key].id, null)
  sql_license_type                 = try(each.value.mssql_settings.sql_license_type, null)
  r_services_enabled               = try(each.value.mssql_settings.r_services_enabled, null)
  sql_connectivity_port            = try(each.value.mssql_settings.sql_connectivity_port, null)
  sql_connectivity_type            = try(each.value.mssql_settings.sql_connectivity_type, null)
  # should the username and password for sql be the same as the one in vm?
  sql_connectivity_update_username = try(each.value.admin_username_key, null) == null ? each.value.admin_username : local.admin_username
  sql_connectivity_update_password = try(each.value.admin_password_key, null) == null ? random_password.admin[local.os_type].result : local.admin_password
  tags                             = merge(local.tags, try(each.value.tags, null))

  dynamic "auto_backup" {
    for_each = try(each.value.mssql_settings.auto_backup, null) != null ? [1] : []

    content {
      encryption_enabled              = try(each.value.mssql_settings.auto_backup.encryption_enabled, null)
      # should the encryption password be different?
      encryption_password             = try(each.value.mssql_settings.auto_backup.encryption_enabled, false) ? try(each.value.admin_password_key, null) == null ? random_password.admin[local.os_type].result : local.admin_password : null
      retention_period_in_days        = each.value.mssql_settings.auto_backup.retention_period_in_days
      system_databases_backup_enabled = try(each.value.mssql_settings.auto_backup.system_databases_backup_enabled, null)
      storage_account_access_key      = data.azurerm_storage_account.mssqlvm_backup_sa[each.key].primary_access_key
      storage_blob_endpoint           = coalesce(
        try(var.storage_accounts[each.value.mssql_settings.auto_backup.storage_account.lz_key][each.value.mssql_settings.auto_backup.storage_account.key].primary_blob_endpoint, null),
        try(var.storage_accounts[var.client_config.landingzone_key][each.value.mssql_settings.auto_backup.storage_account.key].primary_blob_endpoint, null),
      )

      dynamic "manual_schedule" {
        for_each = try(each.value.mssql_settings.auto_backup.manual_schedule, null) != null ? [1] : []

        content {
          full_backup_frequency           = try(each.value.mssql_settings.auto_backup.manual_schedule.full_backup_frequency, null)
          full_backup_start_hour          = try(each.value.mssql_settings.auto_backup.manual_schedule.full_backup_start_hour, null)
          full_backup_window_in_hours     = try(each.value.mssql_settings.auto_backup.manual_schedule.full_backup_window_in_hours, null)
          log_backup_frequency_in_minutes = try(each.value.mssql_settings.auto_backup.manual_schedule.log_backup_frequency_in_minutes, null)
        }
      }

    }
  }

  dynamic "auto_patching" {
    for_each = try(each.value.mssql_settings.auto_patching, null) != null ? [1] : []

    content {
      day_of_week                            = each.value.mssql_settings.auto_patching.day_of_week
      maintenance_window_duration_in_minutes = each.value.mssql_settings.auto_patching.maintenance_window_duration_in_minutes
      maintenance_window_starting_hour       = each.value.mssql_settings.auto_patching.maintenance_window_starting_hour
    }
  }

  # dynamic "key_vault_credentials" {
  #   for_each = try(each.value.mssql_settings.key_vault_credentials, null) != null ? [1] : []

  #   content {
  #     name = each.value.mssql_settings.key_vault_credentials.name
  #     key_vault_url = 
  #     service_principal_name = 
  #     service_principal_secret = 
  #   }
  # }
  
  # should the sp secret be stored in the vm kv or a separate one?
  # if not shared with vm kv, should the kv_url be the same kv as where the sp credential is stored?



  dynamic "storage_configuration" {
    for_each = try(each.value.mssql_settings.storage_configuration, null) != null ? [1] : []

    content {
      disk_type             = each.value.mssql_settings.storage_configuration.disk_type
      storage_workload_type = each.value.mssql_settings.storage_configuration.storage_workload_type

      dynamic "data_settings" {
        for_each = try(each.value.mssql_settings.storage_configuration.data_settings, null) != null ? [1] : []

        content {
          default_file_path = each.value.mssql_settings.storage_configuration.data_settings.default_file_path
          luns              = each.value.mssql_settings.storage_configuration.data_settings.luns
        }
      }
      dynamic "log_settings" {
        for_each = try(each.value.mssql_settings.storage_configuration.log_settings, null) != null ? [1] : []

        content {
          default_file_path = each.value.mssql_settings.storage_configuration.log_settings.default_file_path
          luns              = each.value.mssql_settings.storage_configuration.log_settings.luns
        }
      }
      dynamic "temp_db_settings" {
        for_each = try(each.value.mssql_settings.storage_configuration.temp_db_settings, null) != null ? [1] : []

        content {
          default_file_path = each.value.mssql_settings.storage_configuration.temp_db_settings.default_file_path
          luns              = each.value.mssql_settings.storage_configuration.temp_db_settings.luns
        }
      }

    }
  }

}


# storage account sas

data "azurerm_storage_account" "mssqlvm_backup_sa" {
  for_each = {
    for key, value in try(var.settings.virtual_machine_settings, {}) : key => value
    if try(value.mssql_settings.auto_backup, null) != null
  }

  name                =  coalesce(
      try(var.storage_accounts[each.value.mssql_settings.auto_backup.storage_account.lz_key][each.value.mssql_settings.auto_backup.storage_account.key].name, null),
      try(var.storage_accounts[var.client_config.landingzone_key][each.value.mssql_settings.auto_backup.storage_account.key].name, null),
    )
  resource_group_name =  coalesce(
      try(var.storage_accounts[each.value.mssql_settings.auto_backup.storage_account.lz_key][each.value.mssql_settings.auto_backup.storage_account.key].resource_group_name, null),
      try(var.storage_accounts[var.client_config.landingzone_key][each.value.mssql_settings.auto_backup.storage_account.key].resource_group_name, null),
    )
}