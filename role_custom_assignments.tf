#
# Custom roles assignment
#

# IAM for subscriptions
module custom_role_assignment_subscriptions {
  source   = "./modules/role_assignment"
  for_each = lookup(var.role_mapping.custom_role_mapping, "subscription_keys", {})

  mode               = "custom"
  scope              = each.key == "logged_in_subscription" ? data.azurerm_subscription.primary.id : format("/subscription/%s", var.subscriptions[each.key].subscription_id)
  role_mappings      = each.value
  azuread_apps       = module.azuread_applications
  azuread_groups     = module.azuread_groups
  managed_identities = azurerm_user_assigned_identity.msi
  custom_roles       = try(module.custom_roles, {})
  client_config      = local.client_config
}
