module "caf" {
  source = "../../../../"

  global_settings          = var.global_settings
  resource_groups          = var.resource_groups
  storage_accounts         = var.storage_accounts
  keyvaults                = var.keyvaults
  keyvault_access_policies = var.keyvault_access_policies

  security = {
    keyvault_keys = var.keyvault_keys
  }
}

output storage_accounts {
  value = module.caf.storage_accounts
}
