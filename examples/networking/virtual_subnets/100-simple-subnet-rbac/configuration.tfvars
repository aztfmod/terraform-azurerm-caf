global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}


resource_groups = {
  rg1 = {
    name = "subnet-test-rg"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "test-vnet"
      address_space = ["172.33.0.0/16"]
    }
  }
}


virtual_subnets = {
  subnet1 = {
    name    = "test"
    cidr    = ["172.33.1.0/24"]
    nsg_key = "empty_nsg"
    # service_endpoints = ["Microsoft.ServiceBus"]
    vnet = {
      # id = "/subscriptions/xxxx-xxxx-xxxx-xxx/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet"
      # lz_key = ""
      key = "vnet1"
    }
  }
  subnet2 = {
    name           = "AzureFirewallSubnet"
    special_subnet = true #special_subnet means NO nsg will be created for this subnet
    cidr           = ["172.33.2.0/24"]
    vnet = {
      # id = "/subscriptions/xxxx-xxxx-xxxx-xxx/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet"
      # lz_key = ""
      key = "vnet1"
    }
  }
}

managed_identities = {
  test = {
    # Used by the release agent to access the level0 keyvault and storage account with the tfstates in read / write
    # Assign read access to level0
    name = "msi-test"
    resource_group = {
      # lz_key = "examples"
      key = "rg1"
    }
  }
}

role_mapping = {
  built_in_role_mapping = {
    virtual_subnets = {
      # subcription level access
      subnet1 = {
        "Contributor" = {
          managed_identities = {
            keys = ["test"]
          }
        }
      }
    }
  }
}

