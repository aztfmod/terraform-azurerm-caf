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

public_ip_addresses = {
  lb_pip = {
    name               = "lb_pip1"
    resource_group_key = "lb"
    sku                = "Standard"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Static"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

# Public Load Balancer will be created. For Internal/Private Load Balancer config, please refer 102-internal-load-balancer example.
load_balancers = {
  lb1 = {
    name                      = "lb-test"
    sku                       = "Standard"
    resource_group_key        = "lb"
    backend_address_pool_name = "web-app"
    frontend_ip_configurations = {
      config1 = {
        name                  = "config1"
        public_ip_address_key = "lb_pip"
      }
    }
    diagnostic_profiles = {
      app_service = {
        definition_key   = "slb"
        destination_type = "event_hub"
        destination_key  = "central_logs_example" # Needs to be deployed in launchpad first
      }
    }
  }
}


