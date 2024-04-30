output "id" {
  description = "The Automation Account Runbook ID."
  value       = azurerm_automation_runbook.automation_runbook.id
}

output "name" {
  description = "The Automation Account Runbook name."
  value       = azurerm_automation_runbook.automation_runbook.name
}