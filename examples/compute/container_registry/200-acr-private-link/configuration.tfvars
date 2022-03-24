global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
    region3 = "westeurope"
  }
}


resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  acr_region1 = {
    name = "acr"
  }
  vnet_region1 = {
    name = "acr-vnet"
  }
}

azure_container_registries = {
  acr1 = {
    name               = "acr-test"
    resource_group_key = "acr_region1"
    sku                = "Premium"
    georeplications = {
      region2 = {
        tags = {
          region = "australiacentral"
          type   = "acr_replica"
        }
      }
      region3 = {
        tags = {
          region = "westeurope"
          type   = "acr_replica"
        }
      }
    }

    private_endpoints = {
      hub_rg1-jumphost = {
        name               = "acr-test-private-link"
        resource_group_key = "vnet_region1"
        vnet_key           = "hub_rg1"
        subnet_key         = "jumphost"
        private_service_connection = {
          name                 = "acr-private-link"
          is_manual_connection = false
          subresource_names    = ["registry"]
        }
      }
    }

    # you can setup up to 5 key
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azure_container_registry"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}


vnets = {
  hub_rg1 = {
    resource_group_key = "vnet_region1"
    vnet = {
      name          = "hub"
      address_space = ["100.64.100.0/22"]
    }
    specialsubnets = {}
    subnets = {
      jumphost = {
        name                                           = "jumphost"
        cidr                                           = ["100.64.103.0/27"]
        service_endpoint                               = ["Microsoft.ContainerRegistry"]
        enforce_private_link_endpoint_network_policies = "true"
      }
    }
  }

}