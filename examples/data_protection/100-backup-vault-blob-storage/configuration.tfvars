global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  bv = {
    name   = "bv"
    region = "region1"
  }
}

storage_accounts = {
  bv_st1 = {
    name               = "bv-st1"
    resource_group_key = "bv"
  }
}

backup_vaults = {
  bv0 = {
    backup_vault_name  = "bckp-level0"
    resource_group_key = "bv"
    datastore_type     = "SnapshotStore" #Proper type of vault for storage blob backup
    redundancy         = "LocallyRedundant"
    region             = "region1"
    #Next block enables System Assigned managed identity
    enable_identity = {
      type = "SystemAssigned"
    }
  }
}

role_mapping = {
  built_in_role_mapping = {
    storage_accounts = {
      bv_st1 = {
        "Storage Account Backup Contributor" = {
          backup_vaults = {
            keys = ["bv0"]
          }
        }
      }
    }
  }
}

backup_vault_policies = {
  policy0 = {
    type               = "blob_storage" # policy type, blob_storage and disk supported
    backup_vault_key   = "bv0"
    policy_name        = "backup-policy-lvl0"
    retention_duration = "P50D" #Specific ISO 8601 format
  }
}

backup_vault_instances = {
  instance0 = {
    type                    = "blob_storage" # instance type, blob_storage and disk supported
    instance_name           = "instancebkp0"
    region                  = "region1"
    backup_vault_key        = "bv0"
    backup_vault_policy_key = "policy0"
    storage_account_key     = "bv_st1"
  }
}
