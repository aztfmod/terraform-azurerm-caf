
vnets = {
  sqlmi_region2 = {
    resource_group_key = "networking_region2"
    vnet = {
      name          = "sqlmi-re2"
      address_space = ["172.26.96.0/21"]
    }
    subnets = {
      sqlmi2 = {
        name            = "sqlmi"
        cidr            = ["172.26.96.0/24"]
        nsg_key         = "sqlmi2"
        route_table_key = "sqlmi2"
        delegation = {
          name               = "sqlmidelegation"
          service_delegation = "Microsoft.Sql/managedInstances"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
          ]
        }
      }
    }
  }
}

route_tables = {
  sqlmi2 = {
    name               = "sqlmi2"
    resource_group_key = "networking_region2"
  }
}

vnet_peerings_v1 = {

  # Establish a peering with the devops vnet
  mi_region1-TO-mi_region2 = {
    name = "ti_mi_region2"
    from = {
      lz_key   = "sqlmi1"
      vnet_key = "sqlmi_region1"
    }
    to = {
      vnet_key = "sqlmi_region2"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  # Inbound peer with the devops vnet
  mi_region2-TO-mi_region1 = {
    name = "to_mi_region1"
    from = {
      vnet_key = "sqlmi_region2"
    }
    to = {
      lz_key   = "sqlmi1"
      vnet_key = "sqlmi_region1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}
