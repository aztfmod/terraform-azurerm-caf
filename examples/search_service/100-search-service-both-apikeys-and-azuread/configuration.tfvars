global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
  inherit_tags = true
  #   prefixes      = ["iac-shared"]
  #   random_length = 0
}
data_sources = {
  vnets = {
    vnet_existing = {
      id = "/subscriptions/70aa5e5b-4ae6-4214-8b21-10cb2b78ca73/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet2"
      subnets = {
        snet-01 = {
          id = "/subscriptions/70aa5e5b-4ae6-4214-8b21-10cb2b78ca73/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/vnet2/subnets/default"
        }
      }
    }
  }
}

resource_groups = {
  new_rg = {
    name     = "RG1"
    location = "region1"
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
        subnet_key = "snet-01"
        vnet_key   = "vnet_existing"
        private_service_connection = {
          name                 = "pe-ssconnection"
          is_manual_connection = false
          subresource_names    = ["searchService"]
        }
      }
    }
  }
}