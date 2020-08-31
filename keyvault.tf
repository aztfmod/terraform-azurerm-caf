
module "keyvaults" {
  source   = "./modules/security/keyvault"
  for_each = var.keyvaults

  global_settings = local.global_settings
  keyvault        = each.value
  resource_groups = azurerm_resource_group.rg
  tenant_id       = local.client_config.tenant_id
  diagnostics     = local.diagnostics
  vnets           = lookup(each.value, "network", null) == null ? {} : local.vnets
}

#
# Keyvault access policies
#
# 1- set access policies to the rover logged in user 
# 2 - 


module "keyvault_access_policies" {
  source   = "./modules/security/keyvault_access_policies"
  for_each = var.keyvault_access_policies

  keyvault_id             = module.keyvaults[each.key].id
  access_policies         = each.value
  tenant_id               = local.client_config.tenant_id
  azuread_groups          = module.azuread_groups
  logged_user_objectId    = var.logged_user_objectId
  logged_aad_app_objectId = var.logged_aad_app_objectId
}

# Need to separate keyvault policies from azure ad apps t
module "keyvault_access_policies_azuread_apps" {
  source   = "./modules/security/keyvault_access_policies"
  for_each = var.keyvault_access_policies

  keyvault_id     = module.keyvaults[each.key].id
  access_policies = each.value
  tenant_id       = local.client_config.tenant_id
  azuread_apps    = module.azuread_applications
}



output keyvaults {
  value = module.keyvaults
}
