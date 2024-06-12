global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
}

resource_groups = {
  rg1 = {
    name = "example-rg1"
  }
}

cognitive_services_account = {
  my_account = {
    resource_group = {
      key = "rg1"
    }
    name                  = "pineconellmdemoopenai1"
    kind                  = "OpenAI"
    sku_name              = "S0"
    custom_subdomain_name = "cs-alz-caf-test-b"
    #log_analytics_key = "la1"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "VNet"
      address_space = ["10.0.0.0/16"]
    }
    specialsubnets = {}
    subnets = {
      private_endpoints_subnet = {
        name                                           = "PrivateEndpoints"
        cidr                                           = ["10.0.16.0/24"]
        enforce_private_endpoint_network_policies      = true
        enforce_private_link_endpoint_network_policies = false
      }
    }
  }
}

private_dns = {
  dns1 = {
    name               = "privatelink.openai.azure.com"
    resource_group_key = "rg1"
    vnet_links = {
      vnet_link_01 = {
        name     = "vnet_link_01"
        vnet_key = "vnet1"
      }
    }
  }
}

private_endpoints = {
  vnet1 = {
    vnet_key           = "vnet1"
    subnet_keys        = ["private_endpoints_subnet"]
    resource_group_key = "rg1"
    cognitive_services_account = {
      my_account = {
        private_service_connection = {
          name = "CognitiveServicesPrivateEndpoint"
        }
        private_dns = {
          zone_group_name = "privatelink.openai.azure.com"
          keys            = ["dns1"]
        }
      }
    }
  }
}