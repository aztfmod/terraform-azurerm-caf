global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}
resource_groups = {
  rg-routeserver = {
    name = "rg-routeserver"
  }
}
vnets = {
  vnet-routeserver = {
    resource_group_key = "rg-routeserver"
    vnet = {
      name          = "vnet-routeserver"
      address_space = ["172.20.0.0/24"]
    }
    subnets = {
      RouteServerSubnet = {
        name = "RouteServerSubnet"
        cidr = ["172.20.0.128/27"]
      }
    }
  }
}
public_ip_addresses = {
  virtual_hub_ip = {
    name                    = "pip-aa-conn-vhub"
    resource_group_key      = "rg-routeserver"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}
virtual_hubs = {
  hub1 = {
    hub_name = "vhub-routeserver"
    region   = "region1"
    sku      = "Standard"
    resource_group = {
      key = "rg-routeserver"
    }
    hub_ip = {
      hip1 = {
        name = "vhubip-routeserver"
        subnet = {
          vnet_key   = "vnet-routeserver"
          subnet_key = "RouteServerSubnet"
        }
        private_ip_address           = "172.20.0.134"
        private_ip_allocation_method = "Static"
        public_ip_address = {
          #lz_key = "connectivity"
          public_ip_address_key = "virtual_hub_ip"
        }
      }
    }

  }
}
