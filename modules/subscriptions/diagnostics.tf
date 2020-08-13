module diagnostics {
  source = "/tf/caf/modules/diagnostics"

  for_each = {
    for key in lookup(var.subscription, "diagnostic_keys", []) : key => key
  }

  resource_id       = var.subscription_key == "logged_in_subscription" ? format("/subscriptions/%s", var.primary_subscription_id) : format("/subscriptions/%s", each.value.subscription_id)
  resource_location = var.global_settings.regions[var.global_settings.default_region]
  diagnostics       = var.diagnostics.diagnostics_definition[each.key]
  storage_accounts  = var.diagnostics.storage_accounts
  log_analytics     = var.diagnostics.log_analytics
}