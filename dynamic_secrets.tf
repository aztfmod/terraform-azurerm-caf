
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
      if try(value.value, null) != null # && try(value.value, null) != ""  We want to allow empty values to support our Azdo-PAT usecease in level2
    }
  }

  settings = each.value
  keyvault = local.combined_objects_keyvaults[local.client_config.landingzone_key][each.key]
}


output "dynamic_keyvault_secrets" {
  value = { for key, value in try(var.security.dynamic_keyvault_secrets, {}):
    key =>  module.dynamic_keyvault_secrets[key].secrets
  }
}
# Output looks different then probably expected, its resource_type --> keyvault_key --> secret_key
# dynamic_keyvault_secrets    = { <-- resource_type
#   keyvault_key = {                <-- keyvault_key
#     secret_key = {                <-- secret_key
#       content_type            = ""
#       expiration_date         = null
#       id                      = "https://vault_xy.vault.azure.net/secrets/secret-name/xxx"
#       key_vault_id            = "/subscriptions/1234/resourceGroups/rg-fo/providers/Microsoft.KeyVault/vaults/vault_xy"
#       name                    = "secret-name"
#       not_before_date         = null
#       resource_id             = "/subscriptions/1234/resourceGroups/rg-fo/providers/Microsoft.KeyVault/vaults/vault_xy/secrets/secret-name/versions/xxx"
#       resource_versionless_id = "/subscriptions/1234/resourceGroups/rg-fo/providers/Microsoft.KeyVault/vaults/vault_xy/secrets/secret-name"
#       tags                    = {}
#       timeouts                = null
#       value                   = ""
#       version                 = "xxxxx"
#       versionless_id          = "https://vault_xy.vault.azure.net/secrets/secret-name"
#     }
#   }
# }