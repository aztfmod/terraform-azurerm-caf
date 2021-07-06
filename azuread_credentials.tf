# Module for the CAf variable azuread_apps
module "azuread_credentials" {
  source     = "./modules/azuread/credentials"
  depends_on = [module.keyvault_access_policies]
  for_each   = local.azuread.azuread_credentials

  client_config     = local.client_config
  global_settings   = local.global_settings
  keyvaults         = local.combined_objects_keyvaults
  credential_policy = try(local.azuread.azuread_credential_policies[each.value.azuread_credential_policy_key], null)
  settings          = each.value

  resources = {
    application = {
      id             = try(local.combined_objects_azuread_applications[try(each.value.azuread_application.lz_key, local.client_config.landingzone_key)][each.value.azuread_application.key].id, {})
      application_id = try(local.combined_objects_azuread_applications[try(each.value.azuread_application.lz_key, local.client_config.landingzone_key)][each.value.azuread_application.key].application_id, {})
    }
  }
}

output "azuread_credentials" {
  value = module.azuread_credentials
}
