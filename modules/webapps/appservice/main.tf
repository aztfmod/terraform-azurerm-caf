terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.base_tags, local.module_tag, var.tags)

  arm_filename = "${path.module}/arm_site_config.json"

  app_settings = merge(try(var.app_settings, {}), try(local.dynamic_settings_to_process, {}), var.application_insight == null ? {} :
    {
      "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.application_insight.instrumentation_key,
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.application_insight.connection_string,
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    }
  )

  backup_storage_account = can(var.settings.backup) ? var.storage_accounts[try(var.settings.backup.lz_key, var.client_config.landingzone_key)][var.settings.backup.storage_account_key] : null
  backup_sas_url         = can(var.settings.backup) ? "${local.backup_storage_account.primary_blob_endpoint}${local.backup_storage_account.containers[var.settings.backup.container_key].name}${data.azurerm_storage_account_blob_container_sas.backup[0].sas}" : null

  logs_storage_account = can(var.settings.logs) ? var.storage_accounts[try(var.settings.logs.lz_key, var.client_config.landingzone_key)][var.settings.logs.storage_account_key] : null
  logs_sas_url         = can(var.settings.logs) ? "${local.logs_storage_account.primary_blob_endpoint}${local.logs_storage_account.containers[var.settings.logs.container_key].name}${data.azurerm_storage_account_blob_container_sas.logs[0].sas}" : null

  http_logs_storage_account = can(var.settings.logs.http_logs) ? var.storage_accounts[try(var.settings.logs.http_logs.lz_key, var.client_config.landingzone_key)][var.settings.logs.http_logs.storage_account_key] : null
  http_logs_sas_url         = can(var.settings.logs.http_logs) ? "${local.http_logs_storage_account.primary_blob_endpoint}${local.http_logs_storage_account.containers[var.settings.logs.http_logs.container_key].name}${data.azurerm_storage_account_blob_container_sas.http_logs[0].sas}" : null
}
