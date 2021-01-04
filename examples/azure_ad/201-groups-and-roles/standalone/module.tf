module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  azuread_apps                 = var.azuread_apps
  azuread_users                = var.azuread_users
  azuread_roles                = var.azuread_roles
  azuread_groups               = var.azuread_groups
  keyvaults                    = var.keyvaults
  keyvault_access_policies     = var.keyvault_access_policies
  keyvault_access_policies_azuread_apps = var.keyvault_access_policies_azuread_apps
  role_mapping                 = var.role_mapping
  custom_role_definitions  = var.custom_role_definitions

}
  
