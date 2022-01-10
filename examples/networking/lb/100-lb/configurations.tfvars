global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name = "example-lb"
  }
}


public_ip_addresses = {
  lb_pip = {
    name               = "lb_pip1"
    resource_group_key = "rg1"
    sku                = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Dynamic"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

# Public Load Balancer will be created. For Internal/Private Load Balancer config, please refer 102-internal-load-balancer example.


lb = {
  lb1 = {
    name   = "TestLoadBalancer"
    region = "region1"
    resource_group = {
      key = "rg1"
    }
    frontend_ip_configuration = {
      name = "PublicIPAddress"
      public_ip_address = {
        key = "lb_pip"
      }
    }
  }
}