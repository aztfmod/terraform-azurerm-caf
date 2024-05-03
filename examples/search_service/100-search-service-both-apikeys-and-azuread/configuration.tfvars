global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
  inherit_tags = true
  #   prefixes      = ["iac-shared"]
  #   random_length = 0
}


resource_groups = {
  new_rg = {
    name     = "RG1"
    location = "region1"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "new_rg"
    vnet = {
      name          = "vnet-001"
      address_space = ["10.5.0.0/16"]
    }
    subnets = {
      default = {
        name = "default"
        cidr = ["10.5.1.0/24"]
      }
    }
  }
}

search_services = {
  ss1 = {
    name               = "ss001"
    resource_group_key = "new_rg"
    region             = "region1"
    identity = {
      type = "SystemAssigned"
    }
    sku                          = "basic"
    local_authentication_enabled = true
    authentication_failure_mode  = "http403"
    partition_count              = 1
    replica_count                = 2
    private_endpoints = {
      pe1 = {
        name       = "pe-searchservice"
        subnet_key = "default"
        vnet_key   = "vnet1"
        private_service_connection = {
          name                 = "pe-ssconnection"
          is_manual_connection = false
          subresource_names    = ["searchService"]
        }
      }
    }
  }
}