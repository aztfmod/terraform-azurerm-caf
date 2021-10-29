global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
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

  subnet_group1 = {
    vnet = {
      # id = "/subscriptions/xxxx-xxxx-xxxx-xxx/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet"
      # lz_key = ""
      key = "vnet1"
    }
    subnets = {
      subnet1 = {
        name = "test"
        cidr = ["172.33.1.0/24"]
        nsg_key = "empty_nsg"
        # service_endpoints = ["Microsoft.ServiceBus"]
      }
    }
  }

}

