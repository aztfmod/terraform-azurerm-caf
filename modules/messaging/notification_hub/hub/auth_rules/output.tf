output "id" {
  value = azurerm_notification_hub_authorization_rule.notification_hub_auth_rule.id
}

output "name" {
  value = azurerm_notification_hub_authorization_rule.notification_hub_auth_rule.name
}

output "primary_access_key" {
  value = azurerm_notification_hub_authorization_rule.notification_hub_auth_rule.primary_access_key
}

output "secondary_access_key" {
  value = azurerm_notification_hub_authorization_rule.notification_hub_auth_rule.secondary_access_key
}