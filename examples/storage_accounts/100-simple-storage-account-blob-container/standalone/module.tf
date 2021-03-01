module "caf" {
  source = "../../../../"

  global_settings  = var.global_settings
  resource_groups  = var.resource_groups
  storage_accounts = var.storage_accounts
}

output storage_accounts {
  value = module.caf.storage_accounts
}
