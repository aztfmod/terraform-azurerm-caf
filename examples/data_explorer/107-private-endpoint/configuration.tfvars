global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}

resource_groups = {
  rg1 = {
    name   = "dedicated-test"
    region = "region1"
  }
}
kusto_clusters = {
  kc1 = {
    name              = "kustocluster"
    auto_stop_enabled = false
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name   = ""
    }
    region = "region1"

    sku = {
      name     = "Dev(No SLA)_Standard_E2a_v4"
      capacity = 1
    }

    private_endpoints = {
      pe1 = {
        name               = "kusto-shared"
        resource_group_key = "rg1"
        vnet_key           = "vnet_region1"
        subnet_key         = "private_endpoints"
        private_service_connection = {
          name                 = "kusto-shared"
          is_manual_connection = false
          subresource_names    = ["cluster"]
        }
        private_dns = {
          keys = ["kusto"]
        }
      }
    }
  }
}

## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "rg1"
    region             = "region1"

    vnet = {
      name          = "kusto"
      address_space = ["10.10.0.0/24"]
    }

    subnets = {
      private_endpoints = {
        name                                           = "private-endpoint"
        cidr                                           = ["10.10.0.0/25"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
}

private_dns = {
  kusto = {
    name               = "privatelink.westeurope.kusto.windows.net"
    resource_group_key = "rg1"
  }
}
