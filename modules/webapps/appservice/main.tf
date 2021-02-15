terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.base_tags, local.module_tag, var.tags)

  arm_filename = "${path.module}/arm_site_config.json"

  app_settings = merge(try(var.app_settings, {}), var.application_insight == null ? {} :
    {
      "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.application_insight.instrumentation_key,
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.application_insight.connection_string,
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    }
  )

  backup_storage_account = try(var.settings.backup, null) == null ? null : var.storage_accounts[try(var.settings.backup.lz_key, var.client_config.landingzone_key)][var.settings.backup.storage_account_key]
  backup_sas_url         = try(var.settings.backup, null) == null ? null : "${local.backup_storage_account.primary_blob_endpoint}${local.backup_storage_account.containers[var.settings.backup.container_key].name}${data.azurerm_storage_account_blob_container_sas.backup[0].sas}"
}