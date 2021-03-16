
module "subscriptions" {
  source     = "./modules/subscriptions"
  depends_on = [azurerm_role_assignment.for]

  for_each = var.subscriptions

  global_settings         = local.global_settings
  subscription_key        = each.key
  settings                = each.value
  client_config           = local.client_config
  diagnostics             = local.combined_diagnostics
}
