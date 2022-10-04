resource "azurecaf_name" "automation_job_schedule" {
  name          = var.settings.name
  resource_type = "azurerm_automation_schedule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_automation_job_schedule" "job_schedule" {
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  runbook_name            = var.runbook_name
  schedule_name           = var.schedule_name

  parameters = try(local.parameters_helper, null)

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

locals {
  # See: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/automation_job_schedule#parameters
  # The parameter keys/names must strictly be in lowercase, even if this is not the case in the runbook. 
  # This is due to a limitation in Azure Automation where the parameter names are normalized. 
  # The values specified don't have this limitation  
  parameters_helper = { for key, value in try(var.settings.parameters, {}) : lower(key) => value }
}

