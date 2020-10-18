
module "keyvaults" {
  source   = "./modules/security/keyvault"
  for_each = var.keyvaults

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_groups = module.resource_groups
  tenant_id       = local.client_config.tenant_id
  diagnostics     = local.diagnostics
  vnets           = local.combined_objects_networking
}

#
# Keyvault access policies
#-


module "keyvault_access_policies" {
  source   = "./modules/security/keyvault_access_policies"
  for_each = var.keyvault_access_policies

  keyvault_key            = each.key
  keyvaults               = local.combined_objects_keyvaults
  access_policies         = each.value
  tenant_id               = local.client_config.tenant_id
  azuread_groups          = module.azuread_groups
  logged_user_objectId    = local.client_config.logged_user_objectId
  logged_aad_app_objectId = local.client_config.logged_aad_app_objectId
  managed_identities      = local.combined_objects_managed_identities
}

# Need to separate keyvault policies from azure AD apps to get the keyvault with the default policies.
# Reason - Azure AD apps passwords are stored into keyvault secrets and combining would create a circular reference
module "keyvault_access_policies_azuread_apps" {
  source   = "./modules/security/keyvault_access_policies"
  for_each = var.keyvault_access_policies

  keyvault_key    = each.key
  keyvaults       = local.combined_objects_keyvaults
  access_policies = each.value
  tenant_id       = local.client_config.tenant_id
  azuread_apps    = module.azuread_applications
}


output keyvaults {
  value = module.keyvaults
}
