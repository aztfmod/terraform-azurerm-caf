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

public_ip_addresses = {
  lb_pip = {
    name                    = "lb_pip1"
    resource_group_key      = "lb"
    sku                     = "Standard"
    allocation_method       = "Static"
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
        resource_group_key    = "lb"
        public_ip_address_key = "lb_pip"
      }
    }

    backend_address_pool_addresses = {
      address1 = {
        backend_address_pool_address_name = "address1"
        vnet_key                          = "vnet_test"
        ip_address                        = "10.1.1.1"
      }
    }

    probes = {
      probe1 = {
        resource_group_key = "lb"
        load_balancer_key  = "lb1"
        probe_name         = "probe1"
        port               = "22"
      }
      probe2 = {
        resource_group_key = "lb"
        load_balancer_key  = "lb1"
        probe_name         = "probe2"
        port               = "22"
      }
    }

    outbound_rules = {
      rule1 = {
        name                     = "outbound-rule"
        protocol                 = "Tcp"
        resource_group_key       = "lb"
        backend_address_pool_key = "pool1"
        frontend_ip_configuration = {
          config1 = {
            name = "config1"
          }
        }
      }
    }

    lb_rules = {
      rule1 = {
        resource_group_key             = "lb"
        load_balancer_key              = "lb1"
        lb_rule_name                   = "rule1"
        protocol                       = "tcp"
        probe_id_key                   = "probe1"
        frontend_port                  = "3389"
        backend_port                   = "3389"
        frontend_ip_configuration_name = "config1" #name must match the configuration that's defined in the load_balancers block.
      }
    }

  }
}
