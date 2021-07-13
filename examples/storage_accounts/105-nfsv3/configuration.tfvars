global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
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
    #enable_https_traffic_only = false    #not needed as toggled automatically when nfsv3_enabled is selected.
    is_hns_enabled = true
    nfsv3_enabled  = true                 # This can only be true when account_tier is Standard and account_kind is StorageV2, or account_tier is Premium and account_kind is BlockBlobStorage. 
                                          # Additionally, the is_hns_enabled is true, and enable_https_traffic_only is false
    

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
          subnet_key = "subnet1" # Ensure that this subnet has service_endpoints = ["Microsoft.Storage"] . Without this you will get 404 storage account not found (non descriptive)
        }
        #add multiple subnets by extending this block
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
