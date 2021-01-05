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
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"  # https://docs.microsoft.com/en-us/azure/storage/common/storage-redundancy
    tags = {
      environment = "dev"
      team   = "IT"
      ##
    }
    containers = {
      dev = {
        name = "random"
      }
  }
  }
}


vnets = {
  vnet1 = {
    resource_group_key = "test"
    vnet = {
      name          = "test-vnet"
      address_space = ["10.1.0.0/16"]
    }
    specialsubnets = {}
    subnets = {
      vnet1  = {
        name    = "test_subnet"
        cidr    = ["10.1.1.0/24"]
        enforce_private_link_endpoint_network_policies = true
      }
  }
 }
}

private_endpoints = {
  pep1 = {
    name = "private"
    resource_group_key  = "test"
    vnet_key = "vnet1"
    subnet_key = "subnets"
  }
}
