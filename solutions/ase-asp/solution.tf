module "ase" {
  source = "/tf/caf"

  tags                              = local.tags
  global_settings                   = local.global_settings
  diagnostics                       = local.diagnostics
  resource_groups                   = var.resource_groups
  app_service_environments          = var.app_service_environments
  app_service_plans                 = var.app_service_plans
  networking                        = var.networking
  network_security_group_definition = var.network_security_group_definition
  # logged_user_objectId              = var.logged_user_objectId
  # user_type                         = var.user_type
  # log_analytics                     = var.log_analytics
  # diagnostics_definition            = var.diagnostics_definition
  # diagnostics_destinations          = var.diagnostics_destinations
  # keyvaults                         = var.keyvaults
  # keyvault_access_policies          = var.keyvault_access_policies
  # subscriptions                     = var.subscriptions
  # storage_accounts                  = var.storage_accounts
  # azuread_apps                      = var.azuread_apps
  # azuread_api_permissions           = var.azuread_api_permissions
  # azuread_groups                    = var.azuread_groups
  # azuread_app_roles                 = var.azuread_app_roles
  # azuread_users                     = var.azuread_users
  # managed_identities                = var.managed_identities
  # custom_role_definitions           = var.custom_role_definitions
  # role_mapping                      = var.role_mapping
  # virtual_machines                  = var.virtual_machines
}
