module "caf" {
  source = "../"

  tfstates                    = local.tfstates
  tags                        = local.tags
  global_settings             = local.global_settings
  diagnostics                 = local.diagnostics
  diagnostic_storage_accounts = var.diagnostic_storage_accounts
  logged_user_objectId        = var.logged_user_objectId
  logged_aad_app_objectId     = var.logged_aad_app_objectId
  resource_groups             = var.resource_groups
  app_service_environments    = var.app_service_environments
  app_service_plans           = var.app_service_plans
  app_services                = var.app_services
  storage_accounts            = var.storage_accounts
  azuread_groups              = var.azuread_groups
  keyvaults                   = var.keyvaults
  keyvault_access_policies    = var.keyvault_access_policies
  compute = {
    virtual_machines = var.virtual_machines
    bastion_hosts    = var.bastion_hosts
  }
  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
    firewalls                         = {}
    public_ip_addresses               = var.public_ip_addresses
    private_dns                       = var.private_dns
  }
  database = {
    azurerm_redis_caches = var.azurerm_redis_caches
    mssql_servers        = var.mssql_servers
  }
  # user_type                         = var.user_type
  # log_analytics                     = var.log_analytics
  # diagnostics_destinations          = var.diagnostics_destinations
  # subscriptions                     = var.subscriptions
  # azuread_apps                      = var.azuread_apps
  # azuread_api_permissions           = var.azuread_api_permissions
  # azuread_app_roles                 = var.azuread_app_roles
  # azuread_users                     = var.azuread_users
  # managed_identities                = var.managed_identities
  # custom_role_definitions           = var.custom_role_definitions
  # role_mapping                      = var.role_mapping
}
