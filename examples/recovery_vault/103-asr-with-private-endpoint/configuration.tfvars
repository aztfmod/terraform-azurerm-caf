global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
    region2 = "eastasia"
  }
}

resource_groups = {
  primary = {
    name   = "sharedsvc_re1"
    region = "region1"
  }
  secondary = {
    name   = "sharedsvc_re2"
    region = "region2"
  }
}

recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"
    region = "region1"
    vnet_key                      = "vnet_region1"
    subnet_key                    = "asr_subnet"

    identity = {
      type         = "SystemAssigned"
      identity_ids = null
    }
    
    replication_policies = {
      repl1 = {
        name               = "policy1"
        resource_group_key = "primary"

        recovery_point_retention_in_minutes                  = 24 * 60
        application_consistent_snapshot_frequency_in_minutes = 4 * 60
      }
    }

    recovery_fabrics = {
      fabric1 = {
        name               = "fabric-primary"
        resource_group_key = "primary"
        region             = "region1"
      }
    }

    protection_containers = {
      container1 = {
        name                = "protection_container1"
        resource_group_key  = "primary"
        recovery_fabric_key = "fabric1"
      }
    }

    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      private-link-level4 = {
        name = "sales-asr-rg1"
        vnet_key           = "vnet_region1"
        subnet_key         = "asr_subnet"
        resource_group_key = "primary"

        private_service_connection = {
          name                 = "sales-asr-rg1"
          is_manual_connection = false
          subresource_names    = ["AzureSiteRecovery"]
        }
      }
    }

  }
}

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