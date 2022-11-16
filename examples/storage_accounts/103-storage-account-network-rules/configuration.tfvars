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

# https://docs.microsoft.com/en-us/azure/storage/
storage_accounts = {
  sa1 = {
    name               = "sa1dev"
    resource_group_key = "test"
    # Account types are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2
    account_kind = "BlobStorage"
    # Account Tier options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid.
    account_tier = "Standard"
    #  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
    account_replication_type = "LRS" # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    tags = {
      environment = "dev"
      team        = "IT"
      ##
    }
    network = {
      bypass   = ["Logging", "Metrics"]         #optional. Valid options are any combination of Logging, Metrics, AzureServices, or None
      ip_rules = ["116.86.27.243", "100.1.1.1"] #optional. The prefix of ip_rules must be between 0 and 30 and only supports public IP addresses.
      subnets = {
        subnet1 = {
          #lz_key = ""
          vnet_key   = "vnet1"
          subnet_key = "subnet1"
        }
        #add multiple subnets by extending this block. You can reference remote subnets by using remote_subnet_id
        #subnet2 = {
        #remote_subnet_id = "/subscriptions/*******/resourceGroups/*******/providers/Microsoft.Network/virtualNetworks/vnet-some-remote-vnet/subnets/snet-remote-subnet"
      }

    }
  }
}

