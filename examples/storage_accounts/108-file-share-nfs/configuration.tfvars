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
    name                      = "sa1dev"
    resource_group_key        = "test"
    account_kind              = "FileStorage" #Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_tier              = "Premium"     #Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid
    account_replication_type  = "LRS"         # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    enable_https_traffic_only = false


    tags = {
      environment = "dev"
      team        = "IT"
    }

    network = {
      default_action = "Deny"
      subnets = {
        subnet1 = {
          #lz_key = ""
          vnet_key   = "vnet1"
          subnet_key = "subnet1"
        }
        #add multiple subnets by extending this block
      }

    }
    file_shares = {
      share1 = {
        enabled_protocol = "NFS" # Possible values are SMB and NFS, The NFS indicates the share can be accessed by NFSv4.1. The Premium sku of the azurerm_storage_account is required for the NFS protocol.
        name             = "share1"
        quota            = "110" # For Premium FileStorage storage accounts, this must be greater than 100 GB and less than 102400
      }

    }
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "test"
    vnet = {
      name          = "test-stg"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name              = "test-stg"
        cidr              = ["10.100.100.0/29"]
        service_endpoints = ["Microsoft.Storage"]
      }
    }

  }
}