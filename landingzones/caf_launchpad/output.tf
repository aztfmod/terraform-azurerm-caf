output global_settings {
  value     = local.global_settings
  sensitive = true
}

output diagnostics {
  value     = module.launchpad.diagnostics
  sensitive = true
}

output keyvaults {
  value     = module.launchpad.keyvaults
  sensitive = true
}

output storage_accounts {
  value     = module.launchpad.storage_accounts
  sensitive = true
}

output resource_groups {
  value     = module.launchpad.resource_groups
  sensitive = true
}