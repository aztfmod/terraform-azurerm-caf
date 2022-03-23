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
    allow_blob_public_access = false
    is_hns_enabled           = false

    # Enable this block, if you have a valid domain name
    # custom_domain = {
    #   name          = "any-valid-domain.name" #will be validated by Azure
    #   use_subdomain = true
    # }

    enable_system_msi = {
      type = "SystemAssigned"
    }

    blob_properties = {
      delete_retention_policy = {
        days = "7"
      }

      container_delete_retention_policy = {
        days = "7"
      }
    }

    backup = {
      vault_key = "asr1"
    }

    tags = {
      environment = "dev"
      team        = "IT"
    }

    containers = {
      dev = {
        name = "random"
      }
    }
  }
}

recovery_vaults = {
  asr1 = {
    name               = "asr-container-protection"
    resource_group_key = "test"

    region = "region1"

  }
}