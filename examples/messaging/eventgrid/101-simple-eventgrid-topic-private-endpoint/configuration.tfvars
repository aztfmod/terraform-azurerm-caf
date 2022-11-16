global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  evg_examples = {
    name   = "eventgrid"
    region = "region1"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "evg_examples"
    vnet = {
      name          = "testvnet1"
      address_space = ["10.0.0.0/16"]
    }
    subnets = {
      example = {
        name                                           = "example-subnet"
        cidr                                           = ["10.0.1.0/24"]
        enforce_private_link_endpoint_network_policies = "true"
      }
    }
  }
}

eventgrid_topic = {
  egt1 = {
    name = "egt1"
    resource_group = {
      key = "evg_examples"
    }
    region                        = "region1"
    public_network_access_enabled = false
    tags = {
      Contributor = "Bravent"
    }
    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      private-link-level4 = {
        name       = "egt1"
        vnet_key   = "vnet1"
        subnet_key = "example"
        #subnet_id          = "/subscriptions/97958dac-f75b-4ee3-9a07-9f436fa73bd4/resourceGroups/zlke-rg-egt1/providers/Microsoft.Network/virtualNetworks/egt1-vnet-testvnet1/subnets/zlke-snet-example-subnet"
        resource_group = {
          key = "evg_examples"
        }

        private_service_connection = {
          name                 = "egt1"
          is_manual_connection = false
          subresource_names    = ["topic"]
        }

        # private_dns = {
        #   zone_group_name = "privatelink_database_windows_net"
        #   # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone
        #   keys = ["privatelink"]
        # }
      }
    }
  }
}
