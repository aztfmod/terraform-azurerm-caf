output "id" {
  value = azurerm_notification_hub_authorization_rule.rule.id
}

output "name" {
  value = azurerm_notification_hub_authorization_rule.rule.name
}

output "primary_access_key" {
  value = azurerm_notification_hub_authorization_rule.rule.primary_access_key
}

output "secondary_access_key" {
  value = azurerm_notification_hub_authorization_rule.rule.secondary_access_key
}