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
  tags = merge(var.tags, local.module_tag, var.base_tags)

  arm_filename = "${path.module}/arm_site_config.json"

  app_settings = merge(try(var.app_settings, {}), var.ai_instrumentation_key == null ? {} :
    {
      "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.ai_instrumentation_key,
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = "InstrumentationKey=${var.ai_instrumentation_key}",
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    }
  )

}