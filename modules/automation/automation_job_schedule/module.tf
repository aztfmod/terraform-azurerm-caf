resource "azurerm_automation_job_schedule" "automation_job_schedule" {
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  schedule_name           = var.automation_account_schedule_name
  runbook_name            = var.automation_account_runbook_name
  parameters              = try(var.settings.automation_account_parameters, null)
}
