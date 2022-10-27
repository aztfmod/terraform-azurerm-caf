output "id" {
  description = "The Automation Account ID."
  value       = azurerm_automation_account.auto_account.id
}

output "name" {
  description = "The Automation Account name."
  value       = azurerm_automation_account.auto_account.name
}

output "dsc_server_endpoint" {
  description = "The DSC Server Endpoint associated with this Automation Account."
  value       = azurerm_automation_account.auto_account.dsc_server_endpoint
}

output "rbac_id" {
  description = "The rbac_id of the automation account for role assignments."
  value       = try(azurerm_automation_account.auto_account.identity[0].principal_id, null)
}