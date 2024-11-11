## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "primary"

    vnet = {
      name          = "asrv-vnet-region1"
      address_space = ["10.150.105.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      asr_subnet = {
        name                                           = "asr_subnet"
        cidr                                           = ["10.150.105.0/25"]
        private_endpoint_network_policies = "Enabled"

      }
    }

  }
  vnet_region2 = {
    resource_group_key = "secondary"

    vnet = {
      name          = "asrv-vnet-region2"
      address_space = ["10.150.106.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      asr_subnet = {
        name                                           = "asr_subnet"
        cidr                                           = ["10.150.106.0/25"]
        private_endpoint_network_policies = "Enabled"

      }
    }

  }
}