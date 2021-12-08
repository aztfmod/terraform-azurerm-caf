vnets = {
  vnet_aadds_re1 = {
    resource_group_key = "rg"
    region             = "region1"
    vnet = {
      name          = "vnet-aadds-re1"
      address_space = ["10.1.0.0/28"]
      dns_servers = [
        "10.1.0.4",
        "10.1.0.5",
        "10.1.1.4",
        "10.1.1.5"
      ]
    }
    subnets = {
      aadds = {
        name    = "snet-aadds-re1"
        cidr    = ["10.1.0.0/28"]
        nsg_key = "aadds_re1"
      }
    }
  }
  vnet_aadds_re2 = {
    resource_group_key = "rg"
    region             = "region2"
    vnet = {
      name          = "vnet-aadds-re2"
      address_space = ["10.1.1.0/28"]
      dns_servers = [
        "10.1.1.4",
        "10.1.1.5",
        "10.1.0.4",
        "10.1.0.5"
      ]
    }
    subnets = {
      aadds = {
        name    = "snet-aadds-re2"
        cidr    = ["10.1.1.0/28"]
        nsg_key = "aadds_re2"
      }
    }
  }
}


vnet_peerings = {

  vnet_aadds_re1-TO-vnet_aadds_re2 = {
    name = "vnet_aadds_re1-TO-vnet_aadds_re2"
    from = {
      vnet_key = "vnet_aadds_re1"
    }
    to = {
      vnet_key = "vnet_aadds_re2"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  vnet_aadds_re2-TO-vnet_aadds_re1 = {
    name = "vnet_aadds_re2-TO-vnet_aadds_re1"
    from = {
      vnet_key = "vnet_aadds_re2"
    }
    to = {
      vnet_key = "vnet_aadds_re1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}
