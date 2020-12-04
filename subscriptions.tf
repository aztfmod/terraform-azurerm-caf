
module "subscriptions" {
  source = "./modules/subscriptions"

  for_each = var.subscriptions

  global_settings         = local.global_settings
  subscription_key        = each.key
  subscription            = each.value
  primary_subscription_id = data.azurerm_subscription.primary.subscription_id
  diagnostics             = local.combined_diagnostics
}