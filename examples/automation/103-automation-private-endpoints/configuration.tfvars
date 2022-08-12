# Create log analytics workspace with Updates solution and linked automation account
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  automation = {
    name = "automation"
  }
}

automations = {
  auto1 = {
    name               = "automation"
    sku                = "basic"
    resource_group_key = "automation"

    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      auto1_pe1 = {
        name               = "auto-private-endpoint"
        resource_group_key = "automation"

        # lz_key     = ""
        vnet_key   = "vnet_region1"
        subnet_key = "auto_subnet"

        private_service_connection = {
          name                 = "auto-private-link"
          is_manual_connection = false
          subresource_names    = ["DSCAndHybridWorker"]
        }

        private_dns = {
          zone_group_name = "privatelink.azure-automation.net"
          # lz_key          = ""
          keys = ["auto_dns"]
        }
      }
    }
  }
}

## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "automation"

    vnet = {
      name          = "auto-vnet"
      address_space = ["10.150.102.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      auto_subnet = {
        name                                           = "auto-subnet"
        cidr                                           = ["10.150.102.0/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
}

## DNS configuration
private_dns = {
  auto_dns = {
    name               = "privatelink.azure-automation.net"
    resource_group_key = "automation"

    vnet_links = {
      vnlk1 = {
        name = "auto-vnet-link"
        # lz_key   = ""
        vnet_key = "vnet_region1"
      }
    }
  }
}
