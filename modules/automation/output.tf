output "id" {
  description = "Output the object ID"
  value = azurerm_automation_account.auto_account.id
}

output "name" {
  description = "Output the object name"
  value = azurerm_automation_account.auto_account.name
}

output "object" {
  description   = "Output the full object"
  value         = azurerm_automation_account.auto_account
  sensitive     = true
}