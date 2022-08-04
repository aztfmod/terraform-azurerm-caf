
# When called from the CAF module it can only be used to set secret values
# For that reason, object must not be set.
# This is only used here for examples to run
# the normal recommendation for dynamic keyvault secrets is to call it from a landingzone
module "dynamic_keyvault_secrets" {
  source     = "./modules/security/dynamic_keyvault_secrets"
  depends_on = [module.keyvaults]
  for_each = {
    for keyvault_key, secrets in try(var.security.dynamic_keyvault_secrets, {}) : keyvault_key => {
      for key, value in secrets : key => value
      if try(value.value, null) != null
    }
  }

  settings = each.value
  keyvault = local.combined_objects_keyvaults[local.client_config.landingzone_key][each.key]
}

output "dynamic_keyvault_secrets" {
  value = module.dynamic_keyvault_secrets
}