output "id" {
  description = "The Notification Hub Authorization Rule ID."
  value       = azurerm_notification_hub_authorization_rule.ntf_auth_rules.id
}

output "name" {
  description = "The Notification Hub Authorization Rule name."
  value       = azurerm_notification_hub_authorization_rule.ntf_auth_rules.name
}

output "primary_access_key" {
  description = "The Notification Hub Authorization Rule primary_access_key."
  value       = azurerm_notification_hub_authorization_rule.ntf_auth_rules.primary_access_key
}

output "secondary_access_key" {
  description = "The Notification Hub Authorization Rule secondary_access_key."
  value       = azurerm_notification_hub_authorization_rule.ntf_auth_rules.secondary_access_key
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}

