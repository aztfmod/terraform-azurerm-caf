vnets = {
  vnet_management = {
    resource_group_key = "rg1"
    vnet = {
      name          = "management"
      address_space = ["10.11.12.0/24"]
    }
    subnets = {
      github_agents = {
        name                                           = "gitops"
        cidr                                           = ["10.11.12.0/24"]
        enforce_private_link_endpoint_network_policies = true
        delegation = {
          name               = "Microsoft.ContainerInstance/containerGroups"
          service_delegation = "Microsoft.ContainerInstance/containerGroups"
          actions            = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      }
    }
  }
}
