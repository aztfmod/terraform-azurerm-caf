## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "secondary"

    vnet = {
      name          = "vnet-001"
      address_space = ["10.150.105.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      subnet_001 = {
        name                                           = "privatelink_subnet"
        cidr                                           = ["10.150.105.0/25"]
        enforce_private_link_endpoint_network_policies = "true"
      }
    }

  }
}