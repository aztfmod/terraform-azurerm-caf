module custom_roles {
  source   = "./modules/custom_roles"
  for_each = var.custom_role_definitions

  global_settings      = local.global_settings
  subscription_primary = data.azurerm_subscription.primary.id
  custom_role          = each.value
}