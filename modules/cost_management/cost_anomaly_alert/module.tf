resource "azurerm_cost_anomaly_alert" "cost_anomaly_alert" {
  name            = var.settings.name
  display_name    = var.settings.display_name
  email_subject   = var.settings.email_subject
  email_addresses = coalesce(try(var.settings.email_addresses, null))
  message = try(var.settings.message, null)
}