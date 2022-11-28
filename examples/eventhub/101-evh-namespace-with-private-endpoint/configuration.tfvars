global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  evh_examples = {
    name   = "eventhub"
    region = "region1"
  }
}

event_hub_namespaces = {
  evh1 = {
    name               = "evh1"
    resource_group_key = "evh_examples"
    sku                = "Standard"
    region             = "region1"
    vnet_key           = "vnet_region1"
    subnet_key         = "evh_subnet"

    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      private-link = {
        name               = "sales-evh-rg1"
        vnet_key           = "vnet_region1"
        subnet_key         = "evh_subnet"
        resource_group_key = "evh_examples"

        private_service_connection = {
          name                 = "sales-evh-rg1"
          is_manual_connection = false
          subresource_names    = ["namespace"]
        }
      }
    }

  }

  evh2 = {
    name               = "evh2"
    resource_group_key = "evh_examples"
    sku                = "Standard"
    region             = "region1"
  }
}

## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "evh_examples"

    vnet = {
      name          = "evh-vnet"
      address_space = ["10.150.120.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      evh_subnet = {
        name                                           = "evh_subnet"
        cidr                                           = ["10.150.120.0/25"]
        enforce_private_link_endpoint_network_policies = "true"

      }
    }

  }
}


