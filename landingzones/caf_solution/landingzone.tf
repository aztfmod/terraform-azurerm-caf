module "caf" {
  # source  = "aztfmod/caf/azurerm"
  # version = "~>5.1.0"
  source = "/tf/caf/aztfmod"

  azuread_api_permissions      = var.azuread_api_permissions
  azuread_apps                 = var.azuread_apps
  azuread_groups               = var.azuread_groups
  azuread_roles                = var.azuread_roles
  azuread_users                = var.azuread_users
  compute                      = local.compute
  current_landingzone_key      = var.landingzone.key
  custom_role_definitions      = var.custom_role_definitions
  database                     = local.database
  event_hub_namespaces         = var.event_hub_namespaces
  global_settings              = local.global_settings
  keyvault_access_policies     = var.keyvault_access_policies
  keyvault_certificate_issuers = var.keyvault_certificate_issuers
  keyvaults                    = var.keyvaults
  log_analytics                = var.log_analytics
  logged_aad_app_objectId      = var.logged_aad_app_objectId
  logged_user_objectId         = var.logged_user_objectId
  managed_identities           = var.managed_identities
  networking                   = local.networking
  remote_objects               = local.remote_objects
  resource_groups              = var.resource_groups
  role_mapping                 = var.role_mapping
  security                     = local.security
  storage_accounts             = var.storage_accounts
  subscriptions                = var.subscriptions
  tags                         = local.tags
  tenant_id                    = var.tenant_id
  tfstates                     = local.tfstates
  user_type                    = var.user_type
  webapp                       = local.webapp

  diagnostics = {
    diagnostic_event_hub_namespaces = try(local.diagnostics.diagnostic_event_hub_namespaces, var.diagnostic_event_hub_namespaces)
    diagnostic_log_analytics        = try(local.diagnostics.diagnostic_log_analytics, var.diagnostic_log_analytics)
    diagnostic_storage_accounts     = try(local.diagnostics.diagnostic_storage_accounts, var.diagnostic_storage_accounts)
  }

  shared_services = {
    monitoring      = var.monitoring
    recovery_vaults = var.recovery_vaults
  }
}
