global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
}

resource_groups = {
  test = {
    name = "test"
  }
}

# https://docs.microsoft.com/en-us/azure/storage/
storage_accounts = {
  sa1 = {
    name = "sa1dev"
    # This option is to enable remote RG reference
    # resource_group = {
    #   lz_key = ""
    #   key    = ""
    # }

    resource_group_key = "test"
    # Account types are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_kind = "StorageV2"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard"
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
  }
}


storage_account_file_shares = {
  share1 = {
    name  = "share1"
    quota = 50

    storage_account = {
      # name = ""
      key = "sa1"
      # id   = ""

      # Required to enable backup container storage account
      enable_azurerm_backup_container_storage_account = true
    }

    backups = {
      policy_key = "policy1"
      vault_key  = "asr1"
      # lz_key = ""

    }

    acl = {
      id = "GhostedRecall"

      access_policy = {
        permissions = "r"
      }
    }
  }
}

recovery_vaults = {
  asr1 = {
    name               = "asr-container-protection"
    resource_group_key = "test"

    region = "region1"
    backup_policies = {

      fs = { # File Share backup policies
        policy1 = {
          name      = "FSBackupPolicy1"
          vault_key = "asr1"
          rg_key    = "test"
          timezone  = "UTC"
          backup = {
            frequency = "Daily"
            time      = "23:00"
          }
          retention_daily = {
            count = 10
          }
        }
      }
    }
  }
}

managed_identities = {
  my_msi = { # managed identity key
    name               = "my_msi"
    resource_group_key = "test"
  }
}

role_mapping = {
  built_in_role_mapping = {
    storage_account_file_shares = {
      share1 = {
        "Storage File Data SMB Share Reader" = {
          managed_identities = {
            keys = ["my_msi"]
          }
        }
      }
    }
  }
}