

vnets = {
  spoke = {
    resource_group_key = "spoke"
    region             = "region1"
    vnet = {
      name          = "spoke"
      address_space = ["10.1.0.0/24"]
    }
    specialsubnets = {}
    subnets = {
      container = {
        name = "container"
        cidr = ["10.1.0.0/28"]
        delegation = {
          name               = "Microsoft.ContainerInstance/containerGroups"
          service_delegation = "Microsoft.Network/virtualNetworks/subnets/action"
        }
      }
    }
  }
}

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {
  }
}


network_profiles = {
  np1 = {
    name = "examplenetprofile"
    region = "region1"
    resource_group_key = "container_groups"
    container_network_interface = {
      name = "examplecnic"
      ip_configurations = {
        ip1 = {
          name = "exampleipconfig"
          vnet_key = "spoke"
          subnet_key = "container"
        }
      }
    }
  }
}
