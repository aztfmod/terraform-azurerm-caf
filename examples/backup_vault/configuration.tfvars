backup_vaults = {
  bv0 = {
    backup_vault_name  = "bckp-level0"
    resource_group_key = "level0"
    datastore_type     = "VaultStore" #Proper type of vault for storage blob backup
    redundancy         = "LocallyRedundant"
    region             = "region1"
    #Next block enables System Assigned managed identity
    enable_identity = {
      type = "SystemAssigned"
    }
  }
}


backup_vault_policies = {
  policy0 = {
    backup_vault_key   = "bv0"
    policy_name        = "backup-policy-lvl0"
    retention_duration = "P50D" #Specific ISO 8601 format
  }
}


backup_vault_instances = {
  instance0 = {
    instance_name           = "instancebkp0"
    region                  = "region1"
    backup_vault_key        = "bv0"
    backup_vault_policy_key = "policy0"
    storage_account_key     = "level0"
  }
}
