global_settings = {
  default_region = "region1"
  inherit_tags   = true
  tags = {
    global = "global"
  }
  regions = {
    region1 = "northeurope"
    region2 = "australiacentral"
  }
}

resource_groups = {
  cosmosdb_region1 = {
    name   = "cosmosdb"
    region = "region1"
    tags = {
      rg = "rg"
    }
  }
}

cosmos_dbs = {
  cosmosdb_account_re1 = {
    name                          = "cosmosdb-ex101"
    resource_group_key            = "cosmosdb_region1"
    offer_type                    = "Standard"
    kind                          = "GlobalDocumentDB"
    automatic_failover_enabled     = "true"
    public_network_access_enabled = false

    consistency_policy = {
      consistency_level       = "BoundedStaleness"
      max_interval_in_seconds = "300"
      max_staleness_prefix    = "100000"
    }
    # Primary location (Write Region)
    geo_locations = {
      primary_geo_location = {
        prefix            = "customid-101"
        region            = "region1"
        zone_redundant    = false
        failover_priority = 0
      }
      # failover location
      failover_geo_location = {
        location          = "francecentral"
        failover_priority = 1
      }
    }

    # Optional
    free_tier_enabled = false
    ip_range_filter  = ["116.88.85.63", "116.88.85.64"]
    #capabilities              = ["EnableTable"]
    multiple_write_locations_enabled = false
    tags = {
      "project" = "EDH"
    }

    # Optional - private endpoint
    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      cosmos_db_pe1 = {
        name               = "cosmos-private-endpoint"
        resource_group_key = "cosmosdb_region1"

        # lz_key     = ""
        vnet_key   = "vnet_region1"
        subnet_key = "cosmosdb_subnet"

        private_service_connection = {
          name                 = "cosmos-private-link"
          is_manual_connection = false
          subresource_names    = ["Sql"]
        }

        private_dns = {
          zone_group_name = "cosmosdb-private-dns-zone"
          # lz_key          = ""
          keys = ["cosmos_dns"]
        }
      }
    }
  }
}

## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "cosmosdb_region1"

    vnet = {
      name          = "cosmos-vnet"
      address_space = ["10.150.102.0/24"]

    }
    #specialsubnets = {}
    subnets = {
      cosmosdb_subnet = {
        name                                           = "cosmos-subnet"
        cidr                                           = ["10.150.102.0/25"]
        private_endpoint_network_policies = "Enabled"
      }
    }
  }
}

## DNS configuration
private_dns = {
  cosmos_dns = {
    name               = "documents.azure.com"
    resource_group_key = "cosmosdb_region1"

    vnet_links = {
      vnlk1 = {
        name = "cosmos-vnet-link"
        # lz_key   = ""
        vnet_key = "vnet_region1"
      }
    }
  }
}
