output "id" {
  value = format("/subscriptions/%s", try(azurerm_subscription.sub.0.subscription_id, var.settings.subscription_id, var.client_config.subscription_id))
}
output "subscription_id" {
  value = try(azurerm_subscription.sub.0.subscription_id, var.settings.subscription_id, var.client_config.subscription_id)
}

output "tenant_id" {
  value = try(azurerm_subscription.sub.0.tenant_id, var.client_config.tenant_id)
}

output "tags" {
  value = try(var.settings.tags, null)
}