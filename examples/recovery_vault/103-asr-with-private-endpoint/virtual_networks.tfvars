## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "primary"

    vnet = {
      name          = "asrv-vnet"
      address_space = ["10.150.105.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      asr_subnet = {
        name                                           = "asr_subnet"
        cidr                                           = ["10.150.105.0/25"]
        enforce_private_link_endpoint_network_policies = "true"

      }
    }

  }
}