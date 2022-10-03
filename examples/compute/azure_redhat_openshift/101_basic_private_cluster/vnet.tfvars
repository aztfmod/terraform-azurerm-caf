vnets = {
  vnet1 = {
    resource_group_key = "aro1"
    vnet = {
      name          = "aro-vnet"
      address_space = ["10.1.0.0/16"]
    }
    subnets = {
      subnet1 = {
        name                                           = "master"
        cidr                                           = ["10.1.1.0/24"]
        service_endpoints                              = ["Microsoft.ContainerRegistry", "Microsoft.Storage"]
        enforce_private_link_service_network_policies  = true
        enforce_private_link_endpoint_network_policies = true
      }
      subnet2 = {
        name              = "worker"
        cidr              = ["10.1.2.0/24"]
        service_endpoints = ["Microsoft.ContainerRegistry", "Microsoft.Storage"]
      }

    }
  }
}