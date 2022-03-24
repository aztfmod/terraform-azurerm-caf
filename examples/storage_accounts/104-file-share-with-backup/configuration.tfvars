global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
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
    name                     = "sa1dev"
    resource_group_key       = "test"
    account_kind             = "StorageV2" #Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_tier             = "Standard"  #Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid
    account_replication_type = "LRS"       # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    min_tls_version          = "TLS1_2"    # Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_0 for new storage accounts.
    large_file_share_enabled = true

    # azure_files_authentication = {
    #   directory_type = "AADDS"
    # }

    file_shares = {
      share1 = {
        name  = "myfileshare"
        quota = "10"

        directories = {
          dir1 = {
            name = "testdirectory"
          }
        }
        files = {
          file1 = {
            name = "fileA"
            # source = "/tf/caf/examples/storage_accounts/104-file-share-with-backup/fileA"
            # Prefer the relative path for CI
            source = "./storage_accounts/104-file-share-with-backup/fileA"
          }
          file2 = {
            name   = "fileB"
            source = "./storage_accounts/104-file-share-with-backup/fileB"
            path   = "testdirectory"
          }
          file3 = {
            name   = "fileC"
            source = "./storage_accounts/104-file-share-with-backup/fileC"
            path   = "testdirectory"
          }
        }

        # backups = {
        #   policy_key = "policy1"
        # }
        # Issue: https://github.com/terraform-providers/terraform-provider-azurerm/issues/11184

      }
    }

    backup = {
      vault_key = "asr1"
      # lz_key = ""
    }

    tags = {
      environment = "dev"
      team        = "IT"
    }
  }
}

recovery_vaults = {
  asr1 = {
    name               = "asr-container-protection"
    resource_group_key = "test"

    region = "region1"
    backup_policies = {

      fs = {
        policy1 = {
          name      = "FSBackupPolicy1"
          vault_key = "asr1"
          rg_key    = "primary"
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