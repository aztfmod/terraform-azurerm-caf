vnets = {
  vnet_01 = {
    resource_group_key = "rg1"
    region             = "region1"
    vnet = {
      name          = "vnet-01"
      address_space = ["10.100.1.128/25"]
    }
    specialsubnets = {}

    subnets = {

      subnet_01 = {
        name                                           = "subnet-01"
        cidr                                           = ["10.100.1.128/25"]
        enforce_private_link_endpoint_network_policies = "true"
      }

    }

  }

}
