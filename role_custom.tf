module custom_roles {
  source   = "/tf/caf/modules/custom_roles"
  for_each = var.custom_role_definitions

  global_settings      = var.global_settings
  subscription_primary = data.azurerm_subscription.primary.id
  custom_role          = each.value
}