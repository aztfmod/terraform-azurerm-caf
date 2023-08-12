resource_groups = {
  vnet_spoke_re1 = {
    name   = "vnet-spoke-re1"
    region = "region1"
  }
}

vnets = {
  vnet_spoke = {
    resource_group_key = "vnet_spoke_re1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.101.0/24"]

      dns_servers_keys = {
        dns_server_1 = {
          resource_type = "private_dns_resolver"
          lz_key        = "examples_vnet_hub"
          key           = "inbound_endpoint1"
        }
      }

    }
    specialsubnets = {}
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.101.0/29"]
      }
    }

  }
}

vnet_peerings_v1 = {
  spoke_TO_hub = {
    name = "spoke-TO-hub"
    from = {
      vnet_key = "vnet_spoke"
      # lz_key        = "examples"
    }
    to = {
      vnet_key = "vnet_hub"
      lz_key        = "examples_vnet_hub"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  hub_TO_spoke = {
    name = "hub-TO-spoke"
    from = {
      vnet_key = "vnet_hub"
      lz_key        = "examples_vnet_hub"
    }
    to = {
      vnet_key = "vnet_spoke"
      # lz_key        = "examples"
    }
    allow_virtual_network_access = false
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}
