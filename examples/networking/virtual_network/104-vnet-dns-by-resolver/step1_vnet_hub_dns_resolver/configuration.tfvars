
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "norwayeast"
  }
  passthrough = true
}

resource_groups = {
  vnet_hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

private_dns_resolvers = {
  dns_resolver1 = {
    name               = "resolver1"
    resource_group_key = "vnet_hub_re1"
    region             = "norwayeast"
    vnet = {
      #lz_key = ""
      key = "vnet_hub"
      #id = ""
    }
  }
}

private_dns_resolver_inbound_endpoints = {
  inbound_endpoint1 = {
    name = "inbound-endpint1"
    private_dns_resolver = {
      key = "dns_resolver1"
      #lz_key = ""
    }
    ip_configurations = {
      ip_config1 = {
        #subnet_id=""
        vnet = {
          # lz_key        = "examples"
          key = "vnet_hub"
          #id = ""
          subnet_key = "dns_inbound"
        }
      }
    }
  }
}

vnets = {
  vnet_hub = {
    resource_group_key = "vnet_hub_re1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      dns_inbound = {
        name = "dns_inbound"
        cidr = ["10.100.100.0/28"]
      }
    }
  }
}

