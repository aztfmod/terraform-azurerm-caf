# In some instances, the name of the runbook needs to match the name of workflow, using var.settings.name
#
# resource "azurecaf_name" "automation_runbook" {
#   name          = var.settings.name
#   resource_type = "azurerm_automation_runbook"
#   prefixes      = var.global_settings.prefixes
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

resource "azurerm_automation_runbook" "automation_runbook" {
  name                    = var.settings.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  log_verbose             = try(var.settings.log_verbose, null)
  log_progress            = try(var.settings.log_progress, null)
  description             = try(var.settings.description, null)
  runbook_type            = var.settings.runbook_type

  content = try(var.settings.content, null)

  dynamic "publish_content_link" {
    for_each = try(var.settings.publish_content_link, null) == null ? [] : [1]

    content {
      uri = var.settings.publish_content_link.uri
    }
  }

  dynamic "timeouts" {
    for_each = lookup(var.settings, "timeouts", {}) == {} ? [] : [1]

    content {
      create = try(var.settings.timeouts.create, "30m")
      read   = try(var.settings.timeouts.read, "30m")
      update = try(var.settings.timeouts.update, "30m")
      delete = try(var.settings.timeouts.delete, "30m")
    }
  }
}

# locals {
#   script_content = try(var.settings.script_file, null) != null ? file(var.settings.script_file) : var.settings.content
# }