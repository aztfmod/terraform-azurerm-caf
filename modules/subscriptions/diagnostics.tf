module diagnostics {
  source = "../diagnostics"

  resource_id       = var.subscription_key == "logged_in_subscription" ? format("/subscriptions/%s", var.primary_subscription_id) : format("/subscriptions/%s", var.subscription.subscription_id)
  resource_location = var.global_settings.regions[var.global_settings.default_region]
  diagnostics       = var.diagnostics
  profiles          = var.subscription.diagnostic_profiles
}