output subscription_id {
  value       = try(azurerm_subscription.sub.0.subscription_id, var.settings.subscription_id)
}

output tenant_id {
  value       = try(azurerm_subscription.sub.0.tenant_id, var.settings.tenant_id)
}

output tags {
  value       = var.settings.tags
}
