
output "id" {
  description = "Automation job id"
  value       = azurerm_automation_job_schedule.job_schedule.id
}

output "job_schedule_id" {
  description = "Automation job schedule UUID"
  value       = azurerm_automation_job_schedule.job_schedule.job_schedule_id
}
