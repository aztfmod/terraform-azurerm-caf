
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}


resource_groups = {
  private_dns_resolver_region1 = {
    name   = "private-dns-resolver-rg"
    region = "region1"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "private_dns_resolver_region1"
    vnet = {
      name          = "test-vnet"
      address_space = ["172.33.0.0/16"]
    }
  }
}


virtual_subnets = {
  inbound = {
    name    = "inbound-subnet"
    cidr    = ["172.33.1.0/28"]
    nsg_key = "empty_nsg"
    # service_endpoints = ["Microsoft.ServiceBus"]
    vnet = {
      # id = "/subscriptions/xxxx-xxxx-xxxx-xxx/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet"
      # lz_key = ""
      key = "vnet1"
    }
    delegation = {
      name = "Microsoft.Network.dnsResolvers"
      service_delegation = {
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        name    = "Microsoft.Network/dnsResolvers"
      }
    }
  }

  outbound = {
    name    = "uutbound-subnet"
    cidr    = ["172.33.2.0/28"]
    nsg_key = "empty_nsg"
    # service_endpoints = ["Microsoft.ServiceBus"]
    vnet = {
      # id = "/subscriptions/xxxx-xxxx-xxxx-xxx/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet"
      # lz_key = ""
      key = "vnet1"
    }
    delegation = {
      name = "Microsoft.Network.dnsResolvers"
      service_delegation = {
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        name    = "Microsoft.Network/dnsResolvers"
      }
    }
  }

}


private_dns_resolvers = {
  dns_resolver1 = {
    name               = "test-dns-resolver1"
    resource_group_key = "private_dns_resolver_region1"
    region = "southeastasia"
    vnet = {
      #lz_key = ""
      key = "vnet1"
      #id = ""
    }
  }

}

private_dns_resolver_inbound_endpoints = {
  inbound_endpoint1 = {
    name                     = "test-inbound-endpint1"
    private_dns_resolver_key = "dns_resolver1"
    ip_configurations = {
      ip_config1 = {
        #subnet_id=""
        vnet = {
          #lz_key = ""
          key = "vnet1"
          #id = ""
          subnet_key = "inbound"
        }

      }
    }
  }
}

private_dns_resolver_outbound_endpoints = {
  outbound_endpoint1 = {
    name                 = "test-outbound-endpoint1"
    pvt_dns_resolver_key = "dns_resolver1"
    #subnet_id =""
    vnet = {
      #lz_key = ""
      key = "vnet1"
      #id = ""
      subnet_key = "outbound"
    }


  }
}

private_dns_resolver_dns_forwarding_rulesets = {
  dns_forwarding_ruleset1 = {
    name               = "test-forwarding-ruleset1"
    resource_group_key = "private_dns_resolver_region1"
    dns_resolver_outbound_endpoints = {
      outbound_endpoint1 = {
        #lz_key =""
        #id = ""
        key = "outbound_endpoint1"
      }
    }
  }
}

private_dns_resolver_virtual_network_links = {
  dns_resolver_virtual_network_link1 = {
    name = "test-dns-resolver-virtual-network-link1"
    vent = {
      #lz_key = ""
      key = ""
      #id = ""
    }
    dns_forwarding_ruleset = {
      #lz_key = ""
      #id = ""
      key = "dns_forwarding_ruleset1"
    }

  }

}