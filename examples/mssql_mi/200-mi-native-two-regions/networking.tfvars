
vnets = {
  sqlmi_region1 = {
    resource_group_key = "networking_region1"
    vnet = {
      name          = "sqlmi-rg1"
      address_space = ["172.25.88.0/21"]
    }
    subnets = {
      sqlmi1 = {
        name            = "sqlmi1"
        cidr            = ["172.25.88.0/24"]
        nsg_key         = "sqlmi1"
        route_table_key = "sqlmi1"
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
  sqlmi_region2 = {
    resource_group_key = "networking_region2"
    vnet = {
      name          = "sqlmi-re2"
      address_space = ["172.26.96.0/21"]
    }
    subnets = {
      sqlmi2 = {
        name            = "sqlmi2"
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
  sqlmi1 = {
    name               = "sqlmi1"
    resource_group_key = "networking_region1"
  }
  sqlmi2 = {
    name               = "sqlmi2"
    resource_group_key = "networking_region2"
  }
}

vnet_peerings_v1 = {

  # Establish a peering with the devops vnet
  mi_region1-TO-mi_region2 = {
    name = "mi_region1-TO-mi_region2"
    from = {
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
    name = "mi_region2-TO-mi_region1-TO-ase_region1"
    from = {
      vnet_key = "sqlmi_region2"
    }
    to = {
      vnet_key = "sqlmi_region1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}
