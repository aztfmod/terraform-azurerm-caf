terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }

}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag, var.base_tags)

  arm_filename = "${path.module}/arm_site_config.json"

  app_settings = merge(try(var.app_settings, {}), try(local.dynamic_settings_to_process, {}), var.application_insight == null ? {} :
    {
      "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.application_insight.instrumentation_key,
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.application_insight.connection_string,
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    }
  )

}
