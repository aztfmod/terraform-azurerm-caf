#
# Built-in roles
#

# IAM for subscriptions
module role_assignment_subscriptions {
  source   = "./modules/role_assignment"
  for_each = lookup(var.role_mapping.built_in_role_mapping, "subscription_keys", {})

  mode               = "built-in"
  scope              = each.key == "logged_in_subscription" ? data.azurerm_subscription.primary.id : format("/subscriptions/%s", var.subscriptions[each.key].subscription_id)
  role_mappings      = each.value
  azuread_apps       = module.azuread_applications
  azuread_groups     = module.azuread_groups
  managed_identities = azurerm_user_assigned_identity.msi
  client_config      = local.client_config
}

# IAM for resource groups
module role_assignment_resource_groups {
  source   = "./modules/role_assignment"
  for_each = lookup(var.role_mapping.built_in_role_mapping, "resource_group_keys", {})

  mode               = "built-in"
  scope              = azurerm_resource_group.rg[each.key].id
  role_mappings      = each.value
  azuread_apps       = module.azuread_applications
  azuread_groups     = module.azuread_groups
  managed_identities = azurerm_user_assigned_identity.msi
  client_config      = local.client_config
}

# IAM for storage accounts
module role_assignment_storage_accounts {
  source   = "./modules/role_assignment"
  for_each = lookup(var.role_mapping.built_in_role_mapping, "storage_account_keys", {})

  mode               = "built-in"
  scope              = module.storage_accounts[each.key].id
  role_mappings      = each.value
  azuread_apps       = module.azuread_applications
  azuread_groups     = module.azuread_groups
  managed_identities = azurerm_user_assigned_identity.msi
  client_config      = local.client_config
}
