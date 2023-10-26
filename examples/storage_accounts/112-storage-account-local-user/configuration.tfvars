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

keyvaults = {
  kv_user = {
    name                = "localuser"
    resource_group_key  = "test"
    sku_name            = "standard"
    soft_delete_enabled = true
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
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
    is_hns_enabled           = true
    sftp_enabled             = true
    containers = {
      test_example = {
        name = "testcontainer"
      }
      conatiner2 = {
        name = "container2"
      }
    }
    local_users = {
      sftp_user = {
        name                 = "sftpuser"
        ssh_key_enabled      = true
        ssh_password_enabled = true
        home_directory       = "./"
        permission_scope = {
          permissions1 = {
            service       = "blob"
            resource_name = "testcontainer"
            read          = true
            create        = true
          }
          permissions2 = {
            service       = "blob"
            resource_name = "container2"
            read          = true
            create        = true
            delete        = true
          }
        }
        keyvault = {
          key = "kv_user"
        }
      }
    }
  }
}
