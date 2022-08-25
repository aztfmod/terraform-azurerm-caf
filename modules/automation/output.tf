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