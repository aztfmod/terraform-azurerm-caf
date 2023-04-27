
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
  vnet2 = {
    resource_group_key = "private_dns_resolver_region1"
    vnet = {
      name          = "test-vnet1"
      address_space = ["168.33.0.0/16"]
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
      name               = "Microsoft.Network.dnsResolvers"
      service_delegation = "Microsoft.Network/dnsResolvers"
      actions            = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
  outbound = {
    name    = "outbound-subnet"
    cidr    = ["172.33.2.0/28"]
    nsg_key = "empty_nsg"
    # service_endpoints = ["Microsoft.ServiceBus"]
    vnet = {
      # id = "/subscriptions/xxxx-xxxx-xxxx-xxx/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet"
      # lz_key = ""
      key = "vnet1"
    }
    delegation = {
      name               = "Microsoft.Network.dnsResolvers"
      service_delegation = "Microsoft.Network/dnsResolvers"
      actions            = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

}


private_dns_resolvers = {
  dns_resolver1 = {
    name               = "test-dns-resolver1"
    resource_group_key = "private_dns_resolver_region1"
    region             = "southeastasia"
    vnet = {
      #lz_key = ""
      key = "vnet1"
      #id = ""
    }
  }

}

private_dns_resolver_inbound_endpoints = {
  inbound_endpoint1 = {
    name = "test-inbound-endpint1"
    private_dns_resolver = {
      key = "dns_resolver1"
      #lz_key = ""
    }
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
    name = "test-outbound-endpoint1"
    private_dns_resolver = {
      key = "dns_resolver1"
      #lz_key = ""
    }
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
    name = "test-forwarding-ruleset1"
    resource_group = {
      #lz_key = ""
      key = "private_dns_resolver_region1"
    }
    dns_resolver_outbound_endpoints = {
      outbound_endpoint1 = {
        #lz_key =""
        #id = ""
        key = "outbound_endpoint1"
      }
    }
  }
}

private_dns_resolver_forwarding_rules = {
  dns_forwarding_rule1 = {
    name        = "test-forwarding-rule1"
    domain_name = "test.local."
    enabled     = true
    dns_forwarding_ruleset = {
      #lz_key =""
      #id=""
      key = "dns_forwarding_ruleset1"
    }
    target_dns_servers = {
      dns_server1 = {
        ip_address = "10.10.1.10"
        port       = "53"
      }
      dns_server2 = {
        ip_address = "10.10.2.21"
        port       = "53"
      }
    }
    metadata = {
      key = "value"
    }
  }
}



private_dns_resolver_virtual_network_links = {
  dns_resolver_virtual_network_link1 = {
    dns_forwarding_ruleset = {
      #lz_key =""
      #id=""
      key = "dns_forwarding_ruleset1"
    }
    virtual_network_links = {
      vnet1 = {
        #lz_key = ""
        key = "vnet1"
        #id = ""
        name = "test-dns-resolver-virtual-network-link1"
      }
      vnet2 = {
        #lz_key = ""
        key = "vnet2"
        #id = ""
        name = "test-dns-resolver-virtual-network-link2"
      }
    }
  }
}