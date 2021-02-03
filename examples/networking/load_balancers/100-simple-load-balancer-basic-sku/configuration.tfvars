global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  lb = {
    name = "example-lb"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "lb"
    vnet = {
      name          = "test-vn"
      address_space = ["10.2.0.0/16"]
    }
    specialsubnets = {}
    
    subnets = {
      lb = {
        name = "test"
        cidr = ["10.2.1.0/24"]
      }
    }
  }
}

public_ip_addresses = {
  lb_pip = {
    name               = "lb_pip1"
    resource_group_key = "lb"
    sku                = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Dynamic"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

load_balancers = {
  lb1 = {
    name="lb-test"
    sku = "basic"
    resource_group_key = "lb"
    frontend_ip_configuration = {
     config1 = {
       name= "config1"
       public_ip_address_key = "lb_pip"
      #  vnet_key  = "vnet1"
      #  subnet_key = "lb"
    }
   }
  }
}