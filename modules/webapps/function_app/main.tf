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
  tags = var.base_tags ? merge(
    var.global_settings.tags,
    try(var.resource_group.tags, null),
    local.module_tag,
    try(var.tags, null)
    ) : merge(
    local.module_tag,
    try(var.tags,
    null)
  )

  location            = coalesce(var.location, var.resource_group.location)
  resource_group_name = coalesce(var.resource_group_name, var.resource_group.name)

  arm_filename = "${path.module}/arm_site_config.json"

  app_settings = merge(
    var.application_insight == null ? {} : {
      "APPINSIGHTS_INSTRUMENTATIONKEY"             = var.application_insight.instrumentation_key,
      "APPLICATIONINSIGHTS_CONNECTION_STRING"      = var.application_insight.connection_string,
      "ApplicationInsightsAgent_EXTENSION_VERSION" = "~2"
    },
    try(var.app_settings, {}),
    try(local.dynamic_settings_to_process, {})
  )

}
