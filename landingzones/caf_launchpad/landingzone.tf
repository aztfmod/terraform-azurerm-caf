module "launchpad" {
  source = "../.."

  azuread_api_permissions               = var.azuread_api_permissions
  azuread_apps                          = var.azuread_apps
  azuread_groups                        = var.azuread_groups
  azuread_roles                         = var.azuread_roles
  azuread_users                         = var.azuread_users
  current_landingzone_key               = var.landingzone.key
  custom_role_definitions               = var.custom_role_definitions
  enable                                = var.enable
  event_hub_namespaces                  = var.event_hub_namespaces
  global_settings                       = local.global_settings
  keyvault_access_policies              = var.keyvault_access_policies
  keyvault_access_policies_azuread_apps = var.keyvault_access_policies_azuread_apps
  keyvaults                             = var.keyvaults
  log_analytics                         = var.log_analytics
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  logged_user_objectId                  = var.logged_user_objectId
  managed_identities                    = var.managed_identities
  resource_groups                       = var.resource_groups
  role_mapping                          = var.role_mapping
  storage_accounts                      = var.storage_accounts
  subscriptions                         = var.subscriptions
  tags                                  = var.tags
  tenant_id                             = var.tenant_id
  user_type                             = var.user_type

  diagnostics = {
    diagnostics_definition          = var.diagnostics.diagnostics_definition
    diagnostics_destinations        = var.diagnostics.diagnostics_destinations
    diagnostic_event_hub_namespaces = var.diagnostics.diagnostic_event_hub_namespaces
    diagnostic_log_analytics        = var.diagnostics.diagnostic_log_analytics
    diagnostic_storage_accounts     = var.diagnostics.diagnostic_storage_accounts
  }

  compute = {
    virtual_machines = var.compute.virtual_machines
    bastion_hosts    = var.compute.bastion_hosts
  }

  networking = {
    vnets                             = var.networking.vnets
    network_security_group_definition = var.networking.network_security_group_definition
    public_ip_addresses               = var.networking.public_ip_addresses
    azurerm_routes                    = var.networking.azurerm_routes
    route_tables                      = var.networking.route_tables
  }
}
