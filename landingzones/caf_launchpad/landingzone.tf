module "launchpad" {
  source = "/tf/caf"

  tags                              = local.tags
  global_settings                   = local.global_settings
  logged_user_objectId              = var.logged_user_objectId
  user_type                         = var.user_type
  log_analytics                     = var.log_analytics
  diagnostics_definition            = var.diagnostics_definition
  diagnostics_destinations          = var.diagnostics_destinations
  resource_groups                   = var.resource_groups
  keyvaults                         = var.keyvaults
  keyvault_access_policies          = var.keyvault_access_policies
  subscriptions                     = var.subscriptions
  networking                        = var.networking
  network_security_group_definition = var.network_security_group_definition
  storage_accounts                  = var.storage_accounts
  azuread_apps                      = var.azuread_apps
  azuread_groups                    = var.azuread_groups
  azuread_roles                     = var.azuread_roles
  azuread_users                     = var.azuread_users
}
