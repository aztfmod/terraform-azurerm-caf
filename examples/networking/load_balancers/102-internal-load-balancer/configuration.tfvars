global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

resource_groups = {
  lb = {
    name = "example-lb"
  }
}

vnets = {
  vnet_test = {
    resource_group_key = "lb"
    vnet = {
      name          = "vnet-test"
      address_space = ["10.1.0.0/16"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name = "test-sn"
        cidr = ["10.1.1.0/24"]
      }
    }
  }
}


load_balancers = {
  lb1 = {
    name                      = "lb-test"
    sku                       = "basic"
    resource_group_key        = "lb"
    backend_address_pool_name = "web-app"
    frontend_ip_configurations = {
      config1 = {
        name                          = "config1"
        vnet_key                      = "vnet_test"
        subnet_key                    = "subnet1"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }
}

