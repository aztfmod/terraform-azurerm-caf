resource "azurecaf_name" "automation_runbook" {
  name          = var.settings.name
  resource_type = "azurerm_automation_runbook"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_automation_runbook" "automation_runbook" {
  name                    = azurecaf_name.automation_runbook.result
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  log_verbose             = var.settings.log_verbose
  log_progress            = var.settings.log_progress
  description             = try(var.settings.description, null)
  runbook_type            = var.settings.runbook_type

    dynamic "publish_content_link" {
    for_each = try(var.settings.publish_content_link, null) == null ? [] : [1]

    content {
      uri         = publish_content_link.uri
    }
  }
}